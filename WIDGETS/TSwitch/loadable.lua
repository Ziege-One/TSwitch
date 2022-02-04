---------------------------------------------------------------------------
-- TSwitch                                                               --
--                                                                       --
-- Author:  DerRCModellbauer                                             --
-- Original Author:  Jesper Frickmann                                    --
-- Date:    2022-01-16                                                   --
-- Version: 0.3                                                          --
--                                                                       --
-- Copyright (C) EdgeTX                                                  --
--                                                                       --
-- License GPLv2: http://www.gnu.org/licenses/gpl-2.0.html               --
--                                                                       --
-- This program is free software; you can redistribute it and/or modify  --
-- it under the terms of the GNU General Public License version 2 as     --
-- published by the Free Software Foundation.                            --
--                                                                       --
-- See the GNU General Public License for more details.                  --
---------------------------------------------------------------------------
local version = "0.3"

-- Button description; name = title; button = button label; starts with config 1 to 10 
local menu = {
    buttons = {
		{name = "Beleuchtung1", button1 = "Licht11", button2 = "Licht12", button3 = "Licht13", button4 = "Licht14", button5 = "Licht15", button6 = "Licht17", button7 = "Licht17", button8 = "Licht18"},
		{name = "Beleuchtung2", button1 = "Licht21", button2 = "Licht22", button3 = "Licht23", button4 = "Licht24", button5 = "Licht25", button6 = "Licht27", button7 = "Licht27", button8 = "Licht28"},
		{name = "Lichtboot", button1 = "Blaulicht", button2 = "Radar", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
		{name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
		{name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
		{name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
		{name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
		{name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
		{name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
		{name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
	}	
}

-- This code chunk is loaded on demand by the LibGUI widget's main script
-- when the create(...) function is run. Hence, the body of this file is
-- executed by the widget's create(...) function.

-- zone and options were passed as arguments to chunk(...)
local zone, options = ...

-- Miscellaneous constants
local HEADER = 40
local WIDTH  = 225
local HEIGHT = 50
local COL1   = 10
local COL2   = 130
local COL3   = 245
local COL4   = 370
local TOP    = 48
local LEFT   = 9
local ROW    = 56
local UPDATE = false

-- The widget table will be returned to the main script
local widget = { }

-- Load the GUI library by calling the global function declared in the main script.
-- As long as LibGUI is on the SD card, any widget can call loadGUI() because it is global.
local libGUI = loadGUI()

-- Instantiate a new GUI object
local gui = libGUI.newGUI()

local function getls(switch)
	if getValue("ls"..switch)== 1024 then
		return true 
	else
		return false
	end
end

-- Make a minimize button from a custom element
local custom = { }

function custom.draw(focused)
	lcd.drawRectangle(LCD_W - 34, 6, 28, 28, libGUI.colors.primary2)
	lcd.drawFilledRectangle(LCD_W - 30, 19, 20, 3, libGUI.colors.primary2)
	if focused then
		custom.drawFocus(LCD_W - 34, 6, 28, 28)
	end
end

function custom.onEvent(event, touchState)
	if event == EVT_VIRTUAL_ENTER then
		lcd.exitFullScreen()
	end
end

gui.custom(custom, LCD_W - HEADER, 0, HEADER, HEADER)

-- Toggle button
local toggleButton1 = gui.toggleButton(COL1, TOP + 0 * ROW, WIDTH, HEIGHT, menu.buttons[options.Config].button1, false, nil)
local toggleButton2 = gui.toggleButton(COL1, TOP + 1 * ROW, WIDTH, HEIGHT, menu.buttons[options.Config].button2, false, nil)
local toggleButton3 = gui.toggleButton(COL1, TOP + 2 * ROW, WIDTH, HEIGHT, menu.buttons[options.Config].button3, false, nil)
local toggleButton4 = gui.toggleButton(COL1, TOP + 3 * ROW, WIDTH, HEIGHT, menu.buttons[options.Config].button4, false, nil)
local toggleButton5 = gui.toggleButton(COL3, TOP + 0 * ROW, WIDTH, HEIGHT, menu.buttons[options.Config].button5, false, nil)
local toggleButton6 = gui.toggleButton(COL3, TOP + 1 * ROW, WIDTH, HEIGHT, menu.buttons[options.Config].button6, false, nil)
local toggleButton7 = gui.toggleButton(COL3, TOP + 2 * ROW, WIDTH, HEIGHT, menu.buttons[options.Config].button7, false, nil)
local toggleButton8 = gui.toggleButton(COL3, TOP + 3 * ROW, WIDTH, HEIGHT, menu.buttons[options.Config].button8, false, nil)

-- Draw on the screen before adding gui elements
function gui.fullScreenRefresh()
	--print("TSwitch :full")
	-- Draw header
	lcd.drawFilledRectangle(0, 0, LCD_W, HEADER, COLOR_THEME_SECONDARY1)
	lcd.drawText(COL1, HEADER / 2, menu.buttons[options.Config].name, VCENTER + DBLSIZE + libGUI.colors.primary2)
	lcd.drawText(COL4, HEADER / 2, "Version: " ..version, VCENTER + SMLSIZE);
	-- update the buttons if switch extern (onetime)
	if not UPDATE then
		if getls(options.Switch1LS) then
			toggleButton1.value = true
		end
		if getls(options.Switch1LS+1) then
			toggleButton2.value = true
		end
		if getls(options.Switch1LS+2) then
			toggleButton3.value = true
		end
		if getls(options.Switch1LS+3) then
			toggleButton4.value = true
		end
		if getls(options.Switch1LS+4) then
			toggleButton5.value = true
		end
		if getls(options.Switch1LS+5) then
			toggleButton6.value = true
		end
		if getls(options.Switch1LS+6) then
			toggleButton7.value = true
		end
		if getls(options.Switch1LS+7) then
			toggleButton8.value = true
		end	
		UPDATE = true
	end
  
	-- Button
	if toggleButton1.value then
		setStickySwitch(options.Switch1LS-1, true)     -- EdgeTX 2.6 or higher
	else
		setStickySwitch(options.Switch1LS-1, false)    -- EdgeTX 2.6 or higher
	end
	if toggleButton2.value then
		setStickySwitch(options.Switch1LS-0, true)     -- EdgeTX 2.6 or higher
	else
		setStickySwitch(options.Switch1LS-0, false)    -- EdgeTX 2.6 or higher
	end
	if toggleButton3.value then
		setStickySwitch(options.Switch1LS+1, true)     -- EdgeTX 2.6 or higher
	else
		setStickySwitch(options.Switch1LS+1, false)    -- EdgeTX 2.6 or higher
	end
	if toggleButton4.value then
		setStickySwitch(options.Switch1LS+2, true)     -- EdgeTX 2.6 or higher
	else
		setStickySwitch(options.Switch1LS+2, false)    -- EdgeTX 2.6 or higher
	end
	if toggleButton5.value then
		setStickySwitch(options.Switch1LS+3, true)     -- EdgeTX 2.6 or higher
	else
		setStickySwitch(options.Switch1LS+3, false)    -- EdgeTX 2.6 or higher
	end
	if toggleButton6.value then
		setStickySwitch(options.Switch1LS+4, true)     -- EdgeTX 2.6 or higher
	else
		setStickySwitch(options.Switch1LS+4, false)    -- EdgeTX 2.6 or higher
	end
	if toggleButton7.value then
		setStickySwitch(options.Switch1LS+5, true)     -- EdgeTX 2.6 or higher
	else
		setStickySwitch(options.Switch1LS+5, false)    -- EdgeTX 2.6 or higher
	end
	if toggleButton8.value then
		setStickySwitch(options.Switch1LS+6, true)     -- EdgeTX 2.6 or higher
	else
		setStickySwitch(options.Switch1LS+6, false)    -- EdgeTX 2.6 or higher
	end
end

-- Draw in widget mode
function libGUI.widgetRefresh()
	lcd.drawRectangle(0, 0, zone.w, zone.h, COLOR_THEME_EDIT)
	lcd.drawText(5, 5, menu.buttons[options.Config].name)
	if getls(options.Switch1LS) then
		lcd.drawFilledRectangle(5, 27, 60, 15, COLOR_THEME_ACTIVE)
	end
	if getls(options.Switch1LS + 1) then  
		lcd.drawFilledRectangle(70, 27, 60, 15, COLOR_THEME_ACTIVE)
	end
	if getls(options.Switch1LS + 2)  then    
		lcd.drawFilledRectangle(135, 27, 60, 15, COLOR_THEME_ACTIVE)
	end
	if getls(options.Switch1LS + 3)  then    
	lcd.drawFilledRectangle(5, 47, 60, 15, COLOR_THEME_ACTIVE)
	end
	if getls(options.Switch1LS + 4)  then    
		lcd.drawFilledRectangle(70, 47, 60, 15, COLOR_THEME_ACTIVE)
	end
	if getls(options.Switch1LS + 5)  then    
		lcd.drawFilledRectangle(135, 47, 60, 15, COLOR_THEME_ACTIVE)
	end
	if getls(options.Switch1LS + 6)  then    
		lcd.drawFilledRectangle(5, 67, 60, 15, COLOR_THEME_ACTIVE)
	end
	if getls(options.Switch1LS + 7)  then    
		lcd.drawFilledRectangle(70, 67, 60, 15, COLOR_THEME_ACTIVE)
	end
	lcd.drawText(5, 25, menu.buttons[options.Config].button1,SMLSIZE)
	lcd.drawText(70, 25, menu.buttons[options.Config].button2,SMLSIZE)
	lcd.drawText(135, 25, menu.buttons[options.Config].button3,SMLSIZE)
	lcd.drawText(5, 45, menu.buttons[options.Config].button4,SMLSIZE)
	lcd.drawText(70, 45, menu.buttons[options.Config].button5,SMLSIZE)
	lcd.drawText(135, 45, menu.buttons[options.Config].button6,SMLSIZE)
	lcd.drawText(5, 65, menu.buttons[options.Config].button7,SMLSIZE)
	lcd.drawText(70, 65, menu.buttons[options.Config].button8,SMLSIZE)
	UPDATE = false
end

-- This function is called from the refresh(...) function in the main script
function widget.refresh(event, touchState)
	gui.run(event, touchState)
end

function widget.update(opt)
	options = opt
    for variable = -1, 6 do
		local ls = model.getLogicalSwitch(options.Switch1LS + variable);
			--set setLogicalSwitch to STICKY and v1 to it self (because start up set to false) will be fix in next version
		if (ls.func ~= LS_FUNC_STICKY) then
			model.setLogicalSwitch(options.Switch1LS + variable, {func = LS_FUNC_STICKY,v1 = 85 + options.Switch1LS + variable});
			--model.setLogicalSwitch(options.Switch1LS + variable, {func = LS_FUNC_STICKY});
			setStickySwitch(options.Switch1LS + variable, false);
		else
			setStickySwitch(options.Switch1LS + variable, false);
		end	
	end
end

-- Return to the create(...) function in the main script
return widget
