-- 数据类型 nil, boolean, number, string, function, userdata, thread, table
-- nil 空类型只有一种值 nil
print(type(nil), nil)

-- boolean 值只有两种值 true、false
print(type(true), true)
print(type(false), false)

-- number 类型，一般实现为双精度浮点数
print(type(1.1), 1.1)
print(type(1), 1)

-- string 类型
print(type('string'), 'string')

-- userdata 类型，将任意 C 数据保存在 Lua 变量中。
--     这个类型相当于一块原生的内存，除了赋值和相同性判断，Lua 没有为之预定义任何操作。 
--     然而，通过使用 metatable （元表） ，程序员可以为 userdata 自定义一组操作。
--     userdata 不能在 Lua 中创建出来，也不能在 Lua 中修改。这样的操作只能通过 C API。
--     这一点保证了宿主程序完全掌管其中的数据。
-- 具体示例，略。

-- thread 类型，Lua 的线程实际上是协程，并不是操作系统的线程。
T = coroutine.create(function() print('thread running') end)
print(type(T), T)
coroutine.resume(T)

-- table 类型，对应其他语言的 array 和 map
print(type({}), {})
do -- 表赋值
    local function f(i)
        return 'f'..i
    end
    local g = 'abc'
    local t = {}
    t[f(1)] = g
    t[1] = "x" -- 1st exp
    t[2] = "y" -- 2nd exp
    t.x = 1 -- t["x"] = 1
    t[3] = f(2) -- 3rd exp
    t[30] = 23
    t[4] = 45 -- 4th exp
    a = t
end

-- 自动类型转换: 提供数字和字符串的自动类型转换
print(type(1 + "2"))  -- 自动转为数字
print(type(1 .. "2")) -- 自动转为字符串


-- 变量
-- Lua 是动态类型，变量不绑定类型
A = 1
print(A)
A = 'string'
print(A)
local funcs -- local 声明的变量只在当前作用域内有效，没有 local 声明的变量都是全局变量

print(funcs) -- 声明未赋值的变量的类型和值为 nil
print(type(B), B) -- 未定义的变量的类型和值均为 nil
Ta = { a = 1, b = 2 }
function F1() end -- 函数也是一种变量
F1 = function() local c = 1 end -- 和上面的定义完全等价
local function f1() end -- local 支持函数


-- 环境
-- 每个函数都会关联环境表，定义和引用的全局变量都会在这个表中。
-- 局部变量不会在这张表中。
C = "C"
local c = 'c'
print(getfenv().C) -- 获取环境表，参数：1 表示当前函数，2 表示调用该函数的函数，0 表示全局环境表。如果是一个函数，则返回该函数的环境表。
print(getfenv().c) -- local 变量不会存储在在环境表中
-- 默认情况下，函数的环境表和调用者所在的环境是同一张，这就导致在函数中定义的全局变量会逃逸到上层。
function Df()
    D = 1
end
print("D", D)
Df()
print("D", D)
-- 可以通过 setfenv 修改一个函数的
function Ef()
    print("C", C)
    -- 第一个参数和 getfenv 类似，第二个参数为要设置的表
    -- 可以通过 setmetatable 继承上层环境，形成类似链表的结构
    local newEnv = {}
    setmetatable(newEnv, {__index=getfenv(1)})
    setfenv(1, newEnv)
    E1 = 1  -- E1 不会逃逸到全局环境中了
    print("C", C) -- 会查找旧的环境
    print("getfenv", getfenv) -- 会递归的查找 _G
    -- 环境表不设置 _G 的，则找不到全局变量和函数
    setfenv(1, { print = print })
    print("C", C) -- 可以看出已经找不到上层定义的 C 函数了。
    print("getfenv", getfenv) -- 可以看出已经找不到 getfenv 全局函数了。
    E2 = 2 -- E1 不会逃逸到全局环境中了
end
Ef()
print('E1', E1)
print('E2', E2)


-- local 变量存在作用域，变量作用域（语句块）使用 do end 创建
x = 10 -- 全局变量
do -- 新的语句块
    local x = x -- 新的一个 'x', 它的值现在是 10，从下一行开始全局变量 x 被遮蔽了
    print(x) --> 10
    x = x + 1
    do -- 另一个语句块
        local x = x + 1 -- 又一个 'x'
        print(x) --> 12
    end
    print(x) --> 11
end
print(x) --> 10  （取到的是全局的那一个）


-- 局部变量支持函数闭包。
funcs = {}
local x = 20
for i = 1, 10 do  -- 和 js 不同，i 在循环内部，可以正确捕获。
    local y = 0
    funcs[i] = function() print("x, i, y", x, i, y) end
end
for i = 1, 10 do
    funcs[i]()
end
