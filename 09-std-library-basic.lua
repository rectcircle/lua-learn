-- 错误、断言和错误捕捉
assert(1 == 1, '断言函数的消息, 如果第一个参数是 false, 则触发 error')
-- error (message [, level]) -- 抛出异常
-- 保护模式（错误捕捉）
print('pcall has error', pcall(function() error("my error") end))
print('pcall success', pcall(function() return 1 end))
print('xpcall success', pcall(function() return 1 end, function(err) print(err) end))
print('xpcall 1', xpcall(function() error("my error") end, function(err) print(err) end))
print('xpcall 2', xpcall(function() error("my error") end, function(err) print(err) return err end))

-- 环境
print('_G', _G, getfenv()) -- _G 在全局环境中，指向全局环境本身。
-- setfenv()  -- 参见前文

-- 元表
local t, m = {}, {}
print('setmetatable', setmetatable(t, m)) -- 参见前文
print('getmetatable', getmetatable(t), m) -- 参见前文

-- 加载或执行字符串或文件中的 lua 代码
dofile('hello.lua') -- 将文件内的内容作为 lua 代码，并在一个新的语句块中
-- 加载一段 lua 代码作为一个到 lua 函数变量中
load('print("hello")')() -- 参数也可以是一个函数，这个函数会一直返回字符串，知道返回 nil 为止。
loadstring('print("hello")')()
loadfile('hello.lua')()

-- 表的遍历
print('ipairs', ipairs({})) -- （遍历数组） 按照 key 为 1,2,3 ... 的顺序遍历 返回迭代器，一般在 for in 语法中使用
print('pairs', pairs({})) -- （遍历 map） 返回迭代器，一般在 for in 语法中使用
-- next 函数注意事项：1) next 的顺序是没有定义的, 2) 遍历过程中插入 key，是未定义的，但是可以删除修改。
print('next({})', next({}))  -- 如果第一个参数是空表，返回 nil
print("next({'a', 'b'})", next({ 'a', 'b' })) -- 如果第一个参数不是空表，返回第一个元素的 k 和 v
print("next({'a', 'b'}, 1)", next({ 'a', 'b' }, 1)) -- 如果第一个参数不是空表，第二个参数是一个 k，返回该 k 的下一个元素的 k 和 v
print("next({'a', 'b'}, 1)", next({ 'a', 'b' }, 2)) -- 如果第一个参数不是空表，第二个参数是一个 k，该 k 时最后一个元素，返回 nil

-- 打印到标准输出
print('print to stdout')
print(string.format("number=%d, string=%s", 1, s))

-- 不调用元表的方法，而是使用默认行为
print('rawequal', rawequal(1, 1))
print('rawget', rawget({'a'}, 1))
print('rawset', rawset({ 'a' }, 3, 'b')[3])

-- 获取函数参数列表
local function s  (...)
    print('select #', select('#', ...)) -- 返回可变参数的长度
    print('select #', select(2, ...)) -- 返回可变参数第 2 参数起以及之后的所有元素
end
s(1, 2, 3)

-- 类型
print(type(1))

-- 转换
print(type(tonumber('1')))
print(type(tostring(1)))
print('unpack', unpack({1,2,3}))

-- 版本
print(_VERSION)


