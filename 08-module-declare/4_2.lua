mymod4_2 = {}
setmetatable(mymod4_2, {__index=getfenv(1)})
setfenv(1, mymod4_2)

function PrintModule()
    print('my module 4_2')
end
