-- https://www.runoob.com/lua/lua-metatables.html
-- 这些数据类型值的各种操作，如 + - * / . [] 等，都是通过一种称为 metatable 的机制实现的。
-- 在 Lua 有 8 种数据类型 nil, boolean, number, string, function, userdata, thread, table 中。
--     除了 userdata、table 类型外，其他每种类型的所有值，都共享一套内建的 metatable。
--     userdata 和 table，每个对象（实例），都可以配置绑定一个自定义的 metatable。
--     只有 table 的 metatable 可以 Lua 代码更改，其他只能通过 C 语言修改
-- 因此本部分主要介绍如何如何为 table 自定义 metatable，实现类似于其他语言的运算符重载的功能。

function NewComplex(r, i)
    local o = { r = r, i = i }
    function o:print()
        print(r .. "+" .. i .. "i" )
    end
    -- setmetatable 给一个 table 值绑定一个 metatable。
    --   同一个 table 绑定多次会被覆盖
    --   返回值是被覆盖的旧的元表
    --   如果第二个参数为 nil 表示清楚元表
    setmetatable(o, { 
        __add = function(a, b)
            return NewComplex(a.r + b.r, a.i + b.i)
        end
    })
    return o
end

local a = NewComplex(1, 2)
local b = NewComplex(3, 4)
local c = a + b
c.print()

-- __metadata 作用
d = {}
setmetatable(d, {})
setmetatable(d, { __metatable = "not allow change metatable" }) -- 一个表绑定了带有 __metadata 的元表时后
-- setmetatable(d, {})  -- 将不允许重新绑定
print(getmetatable(d)) -- 获取 metatable 只会返回 __metatable 的值。

-- 所有元表事件参见： https://www.lua.org/manual/5.1/manual.html#2.8


-- 针对不同类型的值进行操作时，针对每一种运算法，Lua 都有一套规则来执行 metatable 中定义的元方法。
-- 以 index 事件，为例，对于 table 的执行过程如下所示：
--     首先，查找当前 table 里面是否存在对应的 key 如果存在，则直接返回，否则进行下一步。
--     查找 metatable 的 `__index` 对应的元方法，如果类型为 table，则触发 table 的 index 事件，否则进行下一步。
--     如果类型为 function，则调用该函数，并传递两个参数，分别为当前 table 以及 key。
-- 所有事件的执行逻辑，参见：https://www.lua.org/manual/5.1/manual.html#2.8

-- 垃圾收集：https://www.lua.org/manual/5.1/manual.html#2.10

-- 弱表：https://www.lua.org/manual/5.1/manual.html#2.10.2
