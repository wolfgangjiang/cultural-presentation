# -*- coding: utf-8 -*-
require 'rubygems'
require 'RMagick'

include Magick

class SlideDrawer
  def initialize
    @pages = []
    @image_list = ImageList.new
    @granite = ImageList.new('granite:')
  end

  def page(&block)
    @current_page = Image.new(1024, 768, TextureFill.new(@granite)).
      frame(7, 7, 7, 7, 2, 2, "darkred")

    instance_exec &block
    @image_list << @current_page
  end

  def slide_show
    @image_list.display
  end

  private 

  def text(content, offset_x = 0, offset_y = -100, size = 52)
    d = Draw.new
    d.font = "/usr/share/fonts/truetype/wqy/wqy-microhei.ttc"
    d.pointsize = size
    d.gravity = CenterGravity

    d.annotate(@current_page, 0, 0, offset_x, offset_y, content)
  end

  def text_left(content, offset_x = 0, offset_y = -100, size = 52)
    d = Draw.new
    d.font = "/usr/share/fonts/truetype/wqy/wqy-microhei.ttc"
    d.pointsize = size
    d.gravity = WestGravity

    d.annotate(@current_page, 0, 0, offset_x, offset_y, content)
  end

  def pic(filename, offset_x = 0, offset_y = 40)
    the_pic = Image.read(filename)[0] 
    p [900.0 / the_pic.columns, 500.0 / the_pic.rows]
    resize_factor = 
      [900.0 / the_pic.columns, 600.0 / the_pic.rows].min_by(&:abs)
    the_pic.resize!(resize_factor)
    @current_page.composite!(
      the_pic, CenterGravity, offset_x, offset_y, CopyCompositeOp)
  end
end

def slides(finish_year)
  (1946..finish_year).each do |yr|
    # 当年的各个领域的strength
    $current_year = yr
    $model[:raw][yr].call if $model[:raw][yr]
  end


  history = SlideDrawer.new
  $model[:chronicles].keys.sort.each do |yr|
    history.page do
      text(yr.to_s, -340, -320)
      y_offset = -150
      $model[:chronicles][yr][:event].each do |msg|
        text_left(msg, 250, y_offset, 43)
        y_offset += 90
      end
    end
  end
  history.slide_show
end
