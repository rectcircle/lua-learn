-- if
function IfNumber(i)
    if i > 0 then
        print('>0')
    elseif i < 0 then  -- 可选
        print('<0')
    else               -- 可选
        print('==0')
    end
end
IfNumber(1)
IfNumber(0)
IfNumber(-1)


-- while (不支持 continue)
local i = 0
while i<10 do
    if i == 5 then
        break
    end
    print('while', i)
    i = i+1
end


-- until
i = 0
repeat
    print('until', i)
    i = i + 1
until i >= 5


-- for
-- 数字循环
for i = 1, 3, 1 do  -- 起始(包括), 结束(包括), 步长(可以省略, 默认为 1)
    print('for-num', i)
end
-- 迭代器循环
local a = {"one", "two", "three"}
for k, v in ipairs(a) do
    print('for-it', k, v)
end
do
    local f, s, var = ipairs(a)
    while true do
        local k, v = f(s, var)
        var = k
        if var == nil then break end
        print('for-mock', k, v)
    end
end
