# -*- coding: utf-8 -*-

class Integer
  def 年(&block)
    year self, &block
  end
end

def 这一年(msg, &block)
  event msg, &block
end

def 新领域(name, opt = {})
  opt[:speed] = opt[:发展速度] unless opt[:speed]
  new_field name, opt
end

class String
  def 诞生(opt = {})
    opt[:on] = opt[:用于] unless opt[:on]
    opt[:power] = opt[:能力] unless opt[:power]
    new_language self, opt
  end

  def 能力
    power
  end

  def 能力=(value)
    self.power = value
  end

  def 发展速度
    speed
  end

  def 发展速度=(value)
    self.speed = value
  end

  def 投入(field, opt = {})
    self.take_on field, opt
  end

  def 淡出(field)
    drop_off field
  end
end

