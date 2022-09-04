-- 保留字
--[[
    and       break     do        else      elseif
    end       false     for       function  if
    in        local     nil       not       or
    repeat    return    then      true      until     while
]]
-- 符号
--[[
    +     -     *     /     %     ^     #
    ==    ~=    <=    >=    <     >     =
    (     )     {     }     [     ]
    ;     :     ,     .     ..    ...
]]

print('逻辑运算符', true and false, true or false, not false)
print('数字运算', 1+1, 2-1, 2*3, 1/2, 5%2, 2^10)
print('# 字符串长度(字节数)', #'abc', #'中文')
print('# 表的长度', #{1,2,3})
print('.. 字符串拼接', 'abc' .. '中文')
print('关系运算符', 1 == 1, 1 == '1', 1 ~= 2, 1 <= 2, 1 >= 2, 1 < 2, 1 > 2)
A = 1 -- 赋值
print('() 优先级和函数参数传递', 1 + 2 * 3, (1 + 2) * 3)
T = {A='a', 'b'}
print('创建 table', type(T))
X = 1; Y = 2
print('; 结束一个语句', X, Y)
X, Y = Y, X
print(', 分割函数参数和多次赋值', X, Y)
print(". 访问 table 的指定值 T.A 等价于 T['A']", T.A, T['A'], T[1])
function MyPrint(...)
    print('MyPrint', ...)
end
MyPrint("... 变长参数", T.A, T['A'], T[1])


-- 短注释，以 -- 开头
--[[
    长注释，--紧接着长括号，本例中为 0 级长括号
]]
--[==[
    长注释，--紧接着长括号，本例中为 2 级长括号
]==]


-- 字面量: 字符串
print([[支持单引号，使用 \ 转义]], 'alo\n123"')
print([[支持双引号，使用 \ 转义]], "alo\n123\"")
print([[\数字字面量，转移 assic 码]], '\97lo\10\04923"')
print('[[ ]] 支持多行字符串（0 级长括号）',[[alo
123"]])

print('[==[ ]==] 支持多行字符串（可以有多个=号）（2 级长括号）', [==[
alo
123"]==])


-- 字面量: 数字
print('字面量: 数字', 3, 3.0, 3.1416, 314.16e-2, 0.31416E1, 0xff, 0x56)


-- 字面量: 表
print('表实现数组', { 1, 2, 3 })  -- 下表从 1 开始
print('表实现map', { a = 1, b = 2, c = 3 })
print('表实现map', { ['a'] = 1, ['b'] = 2, ['c'] = 3 })
print('表实现数组', { [1] = 'a', [2] = 'b', [3] = 'c' })

