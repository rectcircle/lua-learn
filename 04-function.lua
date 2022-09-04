-- 函数定义和调用
function GlobalAdd1(a, b) -- 全局函数（方式 1）
    return a + b
end
GlobalAdd2 = function(a, b) -- 全局函数（方式 2）
    return a + b
end
local function localAdd1(a, b) -- 局部函数（方式 1）
    return a + b
end
local localAdd2; localAdd2 = function(a, b) -- -- 局部函数（方式 2）（递归调用时需要这样）
    return a + b
end
print('add', GlobalAdd1(1, 1), GlobalAdd2(1, 1), localAdd1(1, 1), localAdd2(1, 1))


-- 将函数定义到 table 中
local t1 = { name = "abc" }
function t1.PrintName1() -- 方式 1
    print("print t1.name 1", t1.name)
end
t1.PrintName2 = function() -- 方式 2
    print("print t1.name 2", t1.name)
end
t1.PrintName1()
t1.PrintName2()

-- 接收 nil 返回
local nilReturn = (function() return end)()
print("nil return", nilReturn)

-- 返回并接收多个值
function r() return 1, 2, 3 end
local rr1 = r()
print('返回多个值, 接收 1 个', rr1)
local rr1, rr2 = r()
print('返回多个值, 接收 2 个', rr1, rr2)
local rr1, rr2, rr3 = r()
print('返回多个值, 接收 3 个', rr1, rr2, rr3)

-- 可变参数
function f(a, b) print('f(a, b) params:', a, b) end
f(3)
f(3, 4)
f(3, 4, 5)
f(r(), 10)
f(r())
function g(a, b, ...) print('g(a, b, ...) params:', a, b, ...) end
g(3)
g(3, 4)
g(3, 4, 5, 8)
g(5, r())
function g2(...) print('{...}', { ... }) end
g2(1, 2, 3) -- 可变参数转换为一个表
print('table as varargs', unpack({ 'a', 'b', 'c' }))



-- 为 table 定义方法（: 语法）
local t2 = {total=0}
function t2:Add1(a) -- 语法糖，隐含一个 self 变量
    self.total = self.total + a
end
function t2.Add2(self, a)
    self.total = self.total + a
end
t2:Add1(1) -- 语法糖，隐含一个 self 变量传递
t2.Add1(t2, 1)
t2:Add2(1) -- 语法糖，隐含一个 self 变量传递
t2.Add2(t2, 1)
print('t2.total = ', t2.total)
