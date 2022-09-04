
print(package.preload)
for k, v in pairs(package.preload) do
    print(k, v)
end
print(package.path)
for k, v in pairs(package.loaders) do
    -- 第 1 个加载器会从 package.preload 表中查找
    -- 第 2 个加载器会从从 package.path 中查找对应的 lua 文件
    --     比如 package.path = ./?.lua;/usr/local/share/luajit-2.1.0-beta3/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua
    --     会将 require 参数的 . 替换为 / 然后替换 package.path 参数中的 ?，到对应的文件中去加载模块。
    -- 第 3 个加载器会从 package.cpath 中查找对应的 C 动态库
    --     并调用 luaopen_ + 模块名最后一个 - 的后面的字符串，并将 . 替换为 _（如 a.v1-b.c -> luaopen_b_c）。
    -- 第 4 哥加载器，如 a.b.c 模块，会搜索 a 库，并调用 luaopen_a_b_c 函数。
    print(k, v)
end

-- package.loadlib(libname, funcname)  -- 参见：https://www.lua.org/manual/5.1/manual.html#lua_CFunction

print('package.loaded["08-1-module-declare"]', package.loaded["08-1-module-declare"])
local mymod = require('08-1-module-declare') 
print('package.loaded["08-1-module-declare"]', package.loaded["08-1-module-declare"])

print('mymod.constant', mymod.constant)
print('mymod.Add(1,2)', mymod.Add(1, 2))
print('mymod.Abs(-1)', mymod.Abs(-1))

local mymod1_2 = loadfile('./08-1-module-declare.lua')() -- reuqire 函数 ≈ 文件查找规则 + 缓存 + loadfile 函数。
print('mymod1_2.Add(4,5)', mymod1_2.Add(4, 5))

local mymod2 = require('08-module-declare.2')
mymod2.PrintModule()

require('08-module-declare.3_1')
-- mymod3_1.PrintModule() -- 报错找不到 print
require('08-module-declare.3_2')
-- mymod3_2.PrintModule() -- 报错找不到 print
require('08-module-declare.4_1')
mymod4_1.PrintModule()
require('08-module-declare.4_2')
mymod4_2.PrintModule()
