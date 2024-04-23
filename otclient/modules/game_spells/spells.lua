-- Declare global variables to hold UI elements and loop event ID
mainWindow = nil
mainButton = nil
myLoopEventId = nil

-- Initialize the module
function init()
    -- Create and configure main button on the client top menu
    mainButton = modules.client_topmenu.addRightGameToggleButton('mainButton', tr(''), '/images/topbuttons/healthinfo', onoff)
    mainButton:setOn(false)
    
    -- Load main window UI from 'spells.otui' file and attach it to the root panel of the game interface
    mainWindow = g_ui.loadUI('spells.otui', modules.game_interface.getRootPanel())
    -- Hide the minimize button of the main window
    mainWindow:recursiveGetChildById('minimizeButton'):hide()
    
    -- Bind the 'Shift+F12' keyboard shortcut to the onoff function
    local button = mainWindow:recursiveGetChildById('Jump')
    g_keyboard.bindKeyDown('Shift+F12', onoff)
    
    -- Start moving the button if the loop event ID exists
    if myLoopEventId then
        move()
    end
end

-- Clean up resources and event bindings
function terminate()
    -- Hide the main window
    mainWindow:hide()
    -- Unbind the 'Shift+F12' keyboard shortcut
    g_keyboard.unbindKeyDown('Shift+F12')
end

-- Toggle the visibility of the main window
function onoff()
    if mainWindow:isVisible() then
        -- If the main window is visible, close it and set the main button state to off
        mainWindow:close()
        mainButton:setOn(false)
    else
        -- If the main window is not visible, open it and set the main button state to on
        mainWindow:open()
        mainButton:setOn(true)
    end
end

-- Handle closing of the mini window
function onMiniWindowClose()
    -- Set the main button state to off when the mini window is closed
    mainButton:setOn(false)
end

-- Move the button within the main window
function move()
    if mainWindow then
        local button = mainWindow:recursiveGetChildById('Jump')
        -- If the button's right margin is less than 240 pixels, increase it by 15 pixels and schedule another move event
        if  button:getMarginRight() < 240 then
            button:setMarginRight(button:getMarginRight()+15)
            myLoopEventId = scheduleEvent(move,100)
        else
            -- If the button's right margin is equal to or greater than 240 pixels, reset its position and start moving again
            button:setMarginRight(0)
            button:setMarginTop(math.random(0,250))
            move()
        end
    end 
end

-- Reset the button's position
function reset()
    if mainWindow then
        -- Remove the move event from the event scheduler
        removeEvent(myLoopEventId)
        -- Reset the button's position to the top-left corner and start moving again
        local button = mainWindow:recursiveGetChildById('Jump')
        button:setMarginRight(0)
        button:setMarginTop(math.random(0,250))
        move()
    end
end
