# -*- coding: utf-8 -*-
require './slides_drawer.rb'

slide_drawer = SlideDrawer.new

slide_drawer.page do
  text("程序设计语言的一个文化史视角", -30, -120)
  text("兼论Ruby语言在何种意义上是独一无二的", 100, -50, 39)
end

slide_drawer.page do  
  text("Domain Specific Language", 0, -120)
  text("领域       相关      语言", 0, -50)
end

slide_drawer.page do
  text("Eniac", -340, -320)
  pic("./Eniac.jpg")
end

slide_drawer.page do
  text("Fortran程序样例", -300, -320)
  pic("./fortran_sample.png")
end

slide_drawer.page do
  text("打孔卡片", -340, -320)
  pic("./punchcard01.jpg")
end

slide_drawer.page do
  text("打孔卡片", -340, -320)
  pic("./punchcard02.jpg")
end

slide_drawer.page do
  text("Cobol程序样例", -300, -320)
  pic("./cobol_sample.png")
end

slide_drawer.page do
  text("Algol 60程序样例", -300, -320)
  pic("./algol60_sample.png")
end

slide_drawer.slide_show

