# -*- coding: utf-8 -*-
$model = {}
$model[:raw] = {}
$model[:chronicles] = {}

def year(year_num, &block)
  $model[:raw][year_num] = block
end

def event(msg, &block)
  $model[:chronicles][$current_year] ||= {}
  $model[:chronicles][$current_year][:event] ||= []
  $model[:chronicles][$current_year][:event] << msg
  block.call if block
end

def new_field(name, opt = {})
  event(name + "领域兴起")
  $model[:fields] ||= {}
  $model[:fields][name] = {}
  $model[:fields][name][:speed] = opt[:speed] || 1
  $model[:fields][name][:start_year] = $current_year
  $model[:fields][name][:languages] = []
end

def new_language(name, opt = {})
  event(name + "语言诞生")

  fields = opt[:on]
  unless fields.is_a? Array
    fields = [fields]
  end

  fields.each do |fld|
    if $model[:fields].keys.include? fld
      event("进军" + fld + "领域")
    else      
      new_field fld
    end
    $model[:fields][fld][:languages] << name
  end

  $model[:languages] ||= {}
  $model[:languages][name] = {}
  $model[:languages][name][:power] = opt[:power] || 0.1
end

def show_history
  lines = []

  $model[:chronicles].keys.sort.each do |y|
    lines << y.to_s
    $model[:chronicles][y][:event].each do |msg|
      lines << msg
    end
  end

  puts lines
  lines
end

class String
  def power
    $model[:languages][self][:power]
  end

  def power=(value)
    $model[:languages][self][:power] = value
  end

  def speed
    $model[:fields][self][:speed]
  end

  def speed=(value)
    $model[:fields][self][:speed] = value
  end

  def take_on(field, opt = {})
    $model[:fields][field][:languages] << self
    event(self + "进军" + field + "领域")
  end

  def drop_off(field)
    $model[:fields][field][:languages].delete self    
  end
end

def simulate(finish_year, retro = nil)
  fields_strength = {}
  languages_strength = {}
  languages_proportion = {}

  $history = []

  (1946..finish_year).each do |yr|
    # 当年的各个领域的strength
    $current_year = yr
    $model[:raw][yr].call if $model[:raw][yr]

    fields_strength[yr] ||= {}
    if fields_strength[yr - 1].nil? then
      $model[:fields].keys.each do |fld|
        fields_strength[yr][fld] = $model[:fields][fld][:speed]
      end      
    else
      $model[:fields].keys.each do |fld|
        if fields_strength[yr - 1][fld].nil? then
          fields_strength[yr][fld] = $model[:fields][fld][:speed]
        else
          fields_strength[yr][fld] =
            fields_strength[yr - 1][fld] + $model[:fields][fld][:speed]
        end
      end
    end

    next if $model[:languages].nil?

    languages_strength[yr] ||= {}
    if languages_strength[yr - 1].nil? then
      $model[:languages].keys.each do |lang|
        languages_strength[yr][lang] = $model[:languages][lang][:power]
      end
    else
      $model[:languages].keys.each do |lang|
        if languages_strength[yr - 1][lang].nil? then
          languages_strength[yr][lang] = $model[:languages][lang][:power]
        else
          languages_strength[yr][lang] = 
            languages_strength[yr - 1][lang] + $model[:languages][lang][:power]
        end
      end
    end

    lppf = {} # language_proportion_per_field 
    $model[:fields].keys.each do |fld|
      next if $model[:fields][fld][:languages].empty?
      puts "#{fld} => #{$model[:fields][fld][:languages].inspect};"
      lppf[fld] ||= {}
      lppf_strengths = $model[:fields][fld][:languages].map do |lang|
        { lang => languages_strength[yr][lang] }
      end.inject(:merge)
      lppf_strength_sum = lppf_strengths.values.inject(:+)
      $model[:fields][fld][:languages].each do |lang|
        lppf[fld][lang] = lppf_strengths[lang].to_f / lppf_strength_sum
      end
      puts "#{fld} => #{lppf[fld].inspect};"
    end

    $model[:languages].keys.each do |lang|
      $model[:languages][lang][:fields] = $model[:fields].keys.select do |fld|
        $model[:fields][fld][:languages].include? lang
      end
    end

    languages_proportion[yr] = {}
    $model[:languages].keys.each do |lang|
      languages_proportion[yr][lang] = $model[:languages][lang][:fields].map do |fld|
        fields_strength[yr][fld] * lppf[fld][lang]
      end.inject(:+)
    end
  end

  # fields_strength.keys.sort.each do |yr|
  #   puts fields_strength[yr]
  # end

  # languages_strength.keys.sort.each do |yr|
  #   p languages_strength[yr]
  # end

  languages_proportion.keys.sort.each do |lang|
    puts "#{lang} => #{languages_proportion[lang]}"
  end

  if retro
    $history = show_history 
    $simulate_fps = 2
  end
  show_languages_proportion languages_proportion
  if retro
    show_epilog
  end
end

$name_area_width = 10
$bar_area_width = 60
$simulate_fps = 10
def show_languages_proportion(languages_proportion)
  clear_screen = "\e[2J\e[1;1H"  # clear screen and home cursor
  puts clear_screen

  if $history and not $history.empty? then
    $bar_area_width = 40
  end
  max_year = languages_proportion.keys.max

  lines = []
  languages_proportion.keys.sort.each do |yr|
    lp = languages_proportion[yr]

    max_proportion = lp.values.max
    lines = lp.each_pair.map do |lang, proportion|
      lang_word = lang.ljust($name_area_width)
      proportion_bar_length = 
        (proportion.to_f / max_proportion) * $bar_area_width - 2
      proportion_bar_length = 1 if proportion_bar_length < 1
      proportion_bar = "|" + 
        ("#" * proportion_bar_length).ljust($bar_area_width - 1)
      lang_word + proportion_bar
    end

    lines.sort!

    if $history and not $history.empty? then
      (0..20).each do |i|
        if lines[i].nil? then
          lines[i] = " " * ($name_area_width + $bar_area_width)
        end
        lines[i] += " " + $history[i].to_s
      end
      $history = $history.drop(($history.size - 16) / (max_year - yr + 1))
    end

    sleep(1.0 / $simulate_fps)
    puts clear_screen + yr.to_s + "\n" + lines.join("\n")
    # if $milestones.include? yr
    #   sleep 2
    # else
    #   sleep (1.0 / $simulate_fps)
    # end
  end
end

def show_epilog
  puts_with_delay = lambda do |s|
    puts s
    sleep(1.0 / $simulate_fps)
  end


  6.times { puts_with_delay.call "" }

  puts_with_delay.call "姜节汇@EDoctor".center(78)
  puts_with_delay.call "    " + "谢谢大家".center(78)
  13.times { puts_with_delay.call "" }
end
