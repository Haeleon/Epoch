if _G.isEpochHost then 
    print("Host is already running")
end

local w, h, toolbar, body, _term, _turtle
local stateText = "Initializing..."
local stateColor = colors.gray

local function host()
    os.run(body, "/rom/programs/shell.lua")
    -- print("Host shell exited")
end

local function initialize()
    _G.isEpochHost = true

    w, h = term.getSize()

    toolbar = window.create(term.current(), 1, 1, w, 1)
    toolbar.clear()
    body = window.create(term.current(), 1, 2, w, h-1)
    _term = term.redirect(body)

    _turtle = turtle
    local self = require "/epoch/self"
    _G.turtle = self

    _G.os._pullEvent = _G.os.pullEvent
    _G.os.pullEvent = _G.os.pullEventRaw
end

local function handleTerminate()
    _G.os.pullEvent = _G.os._pullEvent
    _G.os._pullEvent = nil

    _G.turtle = _turtle
    term.redirect(_term)
    _G.isEpochHost = nil
    _G.epochHostShell = nil

    -- os.sleep(3)

    term.setCursorPos(1, 1)
    term.clear()
    print("Exited Epoch host")
    -- os.sleep(2)
    return 0
end
    
local function getTerminateEvents()
    while true do
        local event = os.pullEventRaw("terminate")
        if event == "terminate" then
            if not _G.epochHostShell.getRunningProgram() then
                -- handleTerminate()
                return 0
            end
        end
    end
end

local function toolbarHandler()
    while true do
        toolbar.setBackgroundColor(colors.gray)
        toolbar.setTextColor(colors.white)
        toolbar.clear()

        toolbar.setCursorPos(1, 1)
        toolbar.write(
            string.format("%"..w.."s",
                string.format(
                    "%d (%01.1f%%) #%d %s",
                    turtle.getFuelLevel(),
                    turtle.getFuelLevel()*100/turtle.getFuelLimit(),
                    os.computerID(),
                    "\x7f"
                )
            )
        )
    
        toolbar.setCursorPos(1, 1)
        toolbar.setTextColor(stateColor)
        toolbar.write(stateText)
    
        body.restoreCursor()
        os.sleep(0.2)    
    end
end

function networkHandler()
    stateText = "No connection"
    stateColor = colors.red
    while true do
        os.sleep(1)
    end
end    

initialize()
while true do
    local ok, err = pcall(parallel.waitForAny,
        getTerminateEvents,
        toolbarHandler,
        networkHandler,
        host
    )
    
    if ok then
        handleTerminate()
        return 0
    else
        if err == "Terminated" then
        print("Termination caught; restarting")
        pcall(sleep, 0) -- pcall the sleep function since it is also terminateable.
        end
    end
end

