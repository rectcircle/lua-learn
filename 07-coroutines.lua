-- coroutine.wrap 创建一个协程
local cof = coroutine.wrap(function()
    print('cof called')
    print('coroutine.status(co) call from cof', coroutine.status(CO))
end)

-- coroutine.create 创建一个协程
CO = coroutine.create(function(flag, a, b) -- 函数参数为 coroutine.resume
    print('co called')
    print('coroutine.running call from co', coroutine.running())
    print('coroutine.status(co) call from co', coroutine.status(coroutine.running()))
    print("resume1 param:", flag, a, b)
    local resume2_1, c = coroutine.yield('yield1', a + b)
    print("resume2 param:", resume2_1, c)
    cof()
    return "return", a+b+c
end)

print('co', CO)
-- coroutine.status(co) 返回 dead, running, suspend, normal
print('coroutine.status(co) call from main', coroutine.status(CO))
-- coroutine.running() 获取当前函数所在的协程，如果在主协程中调用则返回 nil
print('coroutine.status(co) call from main', coroutine.status(CO))
print('coroutine.running call from main', coroutine.running())
local succ1, yield1, yield2 = coroutine.resume(CO, "resume1", 1, 2)
print('coroutine.status(co) call from main', coroutine.status(CO))
print("yield param and resume return:", succ1, yield1, yield2)
local succ2, ret1, ret2 = coroutine.resume(CO, "resume2", 3)
print('coroutine.status(co) call from main', coroutine.status(CO))
print("function return:", succ2, ret1, ret2)
