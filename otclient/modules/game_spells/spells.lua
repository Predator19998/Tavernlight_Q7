mainWindow = nil
mainButton = nil
myLoopEventId = nil

function init()
    mainButton = modules.client_topmenu.addRightGameToggleButton('mainButton', tr(''), '/images/topbuttons/healthinfo', onoff)
    mainButton:setOn(false)
    mainWindow = g_ui.loadUI('spells.otui', modules.game_interface.getRootPanel())
    mainWindow:recursiveGetChildById('minimizeButton'):hide()
    local button = mainWindow:recursiveGetChildById('Jump')
    g_keyboard.bindKeyDown('Shift+F12', onoff)
    if myLoopEventId then
        move()
    end
end

function terminate()
    mainWindow:hide()
    g_keyboard.unbindKeyDown('Shift+F12')
end

function onoff()
    if mainWindow:isVisible() then
        mainWindow:close()
        mainButton:setOn(false)
    else
        mainWindow:open()
        mainButton:setOn(true)
    end
end

function onMiniWindowClose()
    mainButton:setOn(false)
end


function move()
    if mainWindow then
        local button = mainWindow:recursiveGetChildById('Jump')
        if  button:getMarginRight() < 240 then
            button:setMarginRight(button:getMarginRight()+15)
            myLoopEventId = scheduleEvent(move,100)
        else
            button:setMarginRight(0)
            button:setMarginTop(math.random(0,250))
            move()
        end
    end 
end

function reset()
    if mainWindow then
        removeEvent(myLoopEventId)
        local button = mainWindow:recursiveGetChildById('Jump')
        button:setMarginRight(0)
        button:setMarginTop(math.random(0,250))
        move()
    end
end