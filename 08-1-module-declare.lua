local module = {}

-- 私有函数

local function abs(a)
    if a < 0 then
        return -a
    else
        return a
    end
end

-- 导出的常量
module.constant = "constant"

-- 导出的函数
function module.Add(a, b)
    return a + b
end

-- 导出的函数
function module.Abs(a)
    abs(a)
end

-- 导出模块
return module
