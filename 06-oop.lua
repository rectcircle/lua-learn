-- 通过 table 和 metatable 实现面向对象

-- 类、抽象父类、子类、单继承、实例化。

-- 抽象父类
Shape = { type='none' }
function Shape:new(type) -- 父类构造函数
    local o = {type=type}
    setmetatable(o, { __index = Shape })
    return o
end
function Shape:print() -- 父类方法
    print("type: ", self.type , "area:", self:getArea())
end
function Shape:getArea() -- 待子类实现的方法
    error('no impl')
end

-- 子类
Rectangle = { length = 0, breadth = 0 }
setmetatable(Rectangle, { __index = Shape }) -- 继承父类
function Rectangle:new(length, breadth) -- 子类构造函数
    local o = Shape:new('Rectangle')
    o.length = length
    o.breadth = breadth
    setmetatable(o, { __index = Rectangle })
    return o
end
function Rectangle:getArea() -- 子类实现父类方法 getArea
    return self.length * self.breadth
end
function Rectangle:diagonal()  -- 子类自己的方法
    return (self.length^2 + self.breadth^2)^(0.5)
end
function Rectangle:print() -- 子类覆写方法 print
    print('length: ', self.length, 'breadth: ', self.breadth)
    Shape.print(self) -- 子类调用父类的方法
    print('and diagonal: ', self:diagonal())
end

-- 实例化
local r = Rectangle:new(3, 4)
r:print()
