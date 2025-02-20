-- This file was created by the Epoch installer

if _G.isEpochHost then 
    if _G.epochHostShell then
        print("Host is already running")
    else
        _G.epochHostShell = shell
        -- print("Shell given to Epoch")
    end
    return
end

shell.run('/epoch/update.lua')
shell.run('/epoch/resetAliases.lua')
shell.run('/epoch/toolbar.lua')