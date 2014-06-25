# -*- coding: utf-8 -*-
require './framework'
require './patch_cn'

1946.年 do
  这一年 "人类发明了电子计算机" do
    新领域 "科学计算"
    新领域 "操作系统"
  end
end

1956.年 do
  "Fortran".诞生 :用于 => "科学计算"
end

1959.年 do
  "Lisp".诞生 :用于 => ["学术", "人工智能", "文本处理"]
end

1960.年 do
  "Cobol".诞生 :用于 => ["数据库", "企业应用"]
  "Algol 60".诞生 :用于 => "学术"
  "企业应用".发展速度 = "学术".发展速度 * 4
end

1966.年 do
  这一年 "结构化程序设计思潮兴起"
end

1971.年 do
  "PL/1".诞生 :用于 => "企业应用", :能力 => "Fortran".能力 * 0.3
  "Pascal".诞生 :用于 => "学术"
  "Pascal".能力 = ("Algol 60".能力 + "Lisp".能力) * 1.5
end

1973.年 do
  "C".诞生 :用于 => "操作系统", :能力 => "Pascal".能力 * 5
end

1976.年 do
  新领域 "互联网"
  "C".投入 "互联网"
end

1979.年 do
  这一年 "中文激光照排系统研制成功"
end

1980.年 do
  这一年 "面向对象思潮兴起" do
    "Smalltalk".诞生 :用于 => "学术"
  end
end

1981.年 do
  这一年 "IBM推出PC" do    
    "文本处理".发展速度 *= 1.5
  end
end

1983.年 do
  "ObjectiveC".诞生 :用于 => "学术"
  "ObjectiveC".能力 = ("C".能力 + "Smalltalk".能力) / 2
  "C++".诞生 :用于 => "企业应用", :能力 => "C".能力 * 0.8
end

1986.年 do
  "SQL".诞生 :用于 => "数据库"
  "SQL".能力 = "Cobol".能力 * 4
end

1987.年 do
  "Perl".诞生 :用于 => "文本处理"
  "Perl".能力 = "Lisp".能力 * 1.5
  "Lisp".淡出 "文本处理"
end

1989.年 do
  "Python".诞生 :用于 => ["文本处理", "科学计算", "学术", "人工智能"]
  "Python".能力 = "Perl".能力 * 1
end

1991.年 do
  这一年 "Linux诞生" do
    新领域 "开源思潮"
    "C".投入 "开源思潮"
  end
  新领域 "Web", :发展速度 => "企业应用".发展速度 * 1.3
end

1993.年 do
  "Ruby".诞生 :用于 => "文本处理"
  "Ruby".能力 = "Python".能力
end

1995.年 do
  "PHP".诞生 :用于 => "Web"
  "Java".诞生 :用于 => "企业应用", :能力 => "C++".能力 * 1.5
  "企业应用".发展速度 *= 3
end

1996.年 do
  "Javascript".诞生 :用于 => "Web", :能力 => "Ruby".能力
end

2000.年 do
  "C#".诞生 :用于 => ["企业应用", "互联网"]
  "C#".能力 = "Java".能力
end

2003.年 do
  "Ruby".投入 "Web"
  新领域 "敏捷思潮"
  "Ruby".投入 "敏捷思潮"
  "Python".投入 "敏捷思潮"
end

2007.年 do
  这一年 "Iphone发布" do 
    新领域 "智能移动", :发展速度 => "Web".发展速度 * 3
    "ObjectiveC".投入 "智能移动"
  end
  这一年 "Android发布" do
    "Java".投入 "智能移动"
  end
end

2009.年 do
  "Javascript".投入 "智能移动"
end

$milestones = [1960, 1969, 1976, 1982, 1994, 2001, 2011]
simulate 2011#, :retro
