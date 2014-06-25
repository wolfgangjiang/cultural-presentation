# -*- coding: utf-8 -*-
require './framework'

year 1946 do
  event "人类发明了电子计算机" do
    new_field "科学计算"
    new_field "操作系统"
  end
end

year 1956 do
  new_language "Fortran", :on => "科学计算"
end

year 1959 do
  new_language "Lisp", :on => ["学术", "人工智能", "文本处理"]
end

year 1960 do
  new_language "Cobol", :on => ["数据库", "企业应用"]
  new_language "Algol 60", :on => "学术"
  "企业应用".speed = "学术".speed * 4
end

year 1966 do
  event "结构化程序设计思潮兴起"
end

year 1971 do
  new_language "PL/1", :on => "企业应用", :power => "Fortran".power * 0.3
  new_language "Pascal", :on => "学术"
  "Pascal".power = ("Algol 60".power + "Lisp".power) * 1.5
end

year 1973 do
  new_language "C", :on => "操作系统", :power => "Pascal".power * 5
end

year 1976 do
  new_field "互联网"
  "C".take_on "互联网"
end

year 1979 do
  event "中文激光照排系统研制成功"
end

year 1980 do
  event "面向对象思潮兴起" do
    new_language "Smalltalk", :on => "学术"
  end
end

year 1981 do
  event "IBM推出PC" do
    "文本处理".speed *= 1.5
  end
end

year 1983 do
  new_language "ObjectiveC", :on => "学术"
  "ObjectiveC".power = ("C".power + "Smalltalk".power) / 2
  new_language "C++", :on => "企业应用", :power => "C".power * 0.8
end

year 1986 do
  new_language "SQL", :on => "数据库"
  "SQL".power = "Cobol".power * 4
end

year 1987 do
  new_language "Perl", :on => "文本处理"
  "Perl".power = "Lisp".power * 1.5
  "Lisp".drop_off "文本处理"
end

year 1989 do
  new_language "Python", :on => ["文本处理", "科学计算", "学术", "人工智能"]
  "Python".power = "Perl".power * 1
end

year 1991 do
  event "Linux诞生" do
    new_field "开源思潮"
    "C".take_on "开源思潮"
  end
  new_field "Web", :speed => "企业应用".speed * 1.3
end

year 1993 do
  new_language "Ruby", :on => "文本处理"
  "Ruby".power = "Python".power
end

year 1995 do
  new_language "PHP", :on => "Web"
  new_language "Java", :on => "企业应用", :power => "C++".power * 1.5
  "企业应用".speed *= 3
end

year 1996 do
  new_language "Javascript", :on => "Web", :power => "Ruby".power
end

year 2000 do
  new_language "C#", :on => ["企业应用", "互联网"]
  "C#".power = "Java".power
end

year 2003 do
  "Ruby".take_on "Web"
  new_field "敏捷思潮"
  "Ruby".take_on "敏捷思潮"
  "Python".take_on "敏捷思潮"
end

year 2007 do
  event "Iphone发布" do
    new_field "智能移动", :speed => "Web".speed * 3
    "ObjectiveC".take_on "智能移动"
  end
  event "Android发布" do
    "Java".take_on "智能移动"
  end
end

year 2009 do
  "Javascript".take_on "智能移动"
end

$milestones = [1960, 1969, 1976, 1982, 1994, 2001, 2011]
#simulate 2011, :retro

require './slides_drawer'
slides 2011
