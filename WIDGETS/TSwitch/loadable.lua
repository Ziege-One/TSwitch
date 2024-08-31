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
local version = "0.7"

-- Button description; name = title; button = button label; starts with config 1 to 10 
local menu = {
    buttons = {
	    -- Config 1
		{name = "DGzRS Hecht",
		button1 = "Deckslicht",
		button2 = "Scheinw.",
		button3 = "Positionsl.", 
		button4 = "Hecklicht", 
		button5 = "Suchschein", 
		button6 = "Blaulicht", 
		button7 = "Bucklicht", 
		button8 = "Toplicht"},
		-- Config 2
		{name = "Beleuchtung2",
		button1 = "Licht21",
		button2 = "Licht22",
		button3 = "Licht23",
		button4 = "Licht24",
		button5 = "Licht25",
		button6 = "Licht27",
		button7 = "Licht27",
		button8 = "Licht28"},
		-- Config 3
		{name = "Lichtboot",
		button1 = "Blaulicht", taster1 = 200,
		button2 = "Radar", taster2 = 0, 
		button3 = "3", taster3 = 1000, 
		button4 = "4", taster4 = 0, 
		button5 = "5", taster5 = 100, 
		button6 = "6", taster6 = 0, 
		button7 = "7", taster7 = 100, 
		button8 = "8", taster8 = 0},
		-- Config 4
		{name = "Licht", 
		button1 = "1", 
		button2 = "2", 
		button3 = "3", 
		button4 = "4", 
		button5 = "5", 
		button6 = "6", 
		button7 = "7", 
		button8 = "8"},
		-- Config 5
		{name = "Licht", 
		button1 = "1", 
		button2 = "2", 
		button3 = "3", 
		button4 = "4", 
		button5 = "5", 
		button6 = "6", 
		button7 = "7", 
		button8 = "8"},
		-- Config 6
		{name = "Licht", 
		button1 = "1", 
		button2 = "2", 
		button3 = "3", 
		button4 = "4", 
		button5 = "5", 
		button6 = "6", 
		button7 = "7", 
		button8 = "8"},
		-- Config 7
		{name = "Licht", 
		button1 = "1", 
		button2 = "2", 
		button3 = "3", 
		button4 = "4", 
		button5 = "5", 
		button6 = "6", 
		button7 = "7", 
		button8 = "8"},
		-- Config 8
		{name = "Licht", 
		button1 = "1", 
		button2 = "2", 
		button3 = "3", 
		button4 = "4", 
		button5 = "5", 
		button6 = "6", 
		button7 = "7", 
		button8 = "8"},
		-- Config 9
		{name = "Licht", 
		button1 = "1", 
		button2 = "2", 
		button3 = "3", 
		button4 = "4", 
		button5 = "5", 
		button6 = "6", 
		button7 = "7", 
		button8 = "8"},
		-- Config 10
		{name = "Licht", 
		button1 = "1", 
		button2 = "2", 
		button3 = "3", 
		button4 = "4", 
		button5 = "5", 
		button6 = "6", 
		button7 = "7", 
		button8 = "8"},		

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

-- Make a minimize button from a custom element
local custom = { }

function custom.draw(focused)
	lcd.drawRectangle(LCD_W - 34, 6, 28, 28, libGUI.colors.primary2)
	lcd.drawFilledRectangle(LCD_W - 30, 19, 20, 3, libGUI.colors.primary2)
	if focused then
		custom.drawFocus(LCD_W - 30, 6, 26, 26, libGUI.colors.focus)
	end
end

function custom.onEvent(event, touchState)
  if (touchState) or (event and event == EVT_VIRTUAL_EXIT) or (event and event == EVT_VIRTUAL_ENTER) then
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

----------------------------------------------------------------------------------------------------- Taster
local LST = {0,0,0,0,0,0,0,0,0}
----------------------------------------------------------------------------------------------------- Taster

-- Draw on the screen before adding gui elements
function gui.fullScreenRefresh()
	--print("TSwitch :full")
	-- Draw header
	lcd.drawFilledRectangle(0, 0, LCD_W, HEADER, COLOR_THEME_SECONDARY1)
	lcd.drawText(COL1, HEADER / 2, menu.buttons[options.Config].name, VCENTER + DBLSIZE + libGUI.colors.primary2)
	lcd.drawText(COL4, HEADER / 2, "Version: " ..version, VCENTER + SMLSIZE);
	-- update the buttons if switch extern (onetime)
	if not UPDATE then
        local lsname = "ls" .. options.Switch1LS + 0
        local v = getValue(lsname);
        if v > 0 then
			toggleButton1.value = true
		else
			toggleButton1.value = false
		end
        local lsname = "ls" .. options.Switch1LS + 1
        local v = getValue(lsname);
        if v > 0 then
			toggleButton2.value = true
		else
			toggleButton2.value = false			
		end
        local lsname = "ls" .. options.Switch1LS + 2
        local v = getValue(lsname);
        if v > 0 then
			toggleButton3.value = true
		else
			toggleButton3.value = false			
		end
        local lsname = "ls" .. options.Switch1LS + 3
        local v = getValue(lsname);
        if v > 0 then
			toggleButton4.value = true
		else
			toggleButton4.value = false			
		end
        local lsname = "ls" .. options.Switch1LS + 4
        local v = getValue(lsname);
        if v > 0 then
			toggleButton5.value = true
		else
			toggleButton5.value = false			
		end
        local lsname = "ls" .. options.Switch1LS + 5
        local v = getValue(lsname);
        if v > 0 then
			toggleButton6.value = true
		else
			toggleButton6.value = false			
		end
        local lsname = "ls" .. options.Switch1LS + 6
        local v = getValue(lsname);
        if v > 0 then
			toggleButton7.value = true
		else
			toggleButton7.value = false			
		end
        local lsname = "ls" .. options.Switch1LS + 7
        local v = getValue(lsname);
        if v > 0 then
			toggleButton8.value = true
		else
			toggleButton8.value = false			
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
	----------------------------------------------------------------------------------------------------- Taster
	
	local t = getTime();
	
	if (menu.buttons[options.Config].taster1) then
		if toggleButton1.value and not getLogicalSwitchValue(options.Switch1LS-1) and (menu.buttons[options.Config].taster1 >= 1) then
			LST[1] = t + menu.buttons[options.Config].taster1;
		end
		if (t > LST[1]) and (menu.buttons[options.Config].taster1 >= 1) then
			toggleButton1.value = false
		end
    end	
	
	if (menu.buttons[options.Config].taster2) then
		if toggleButton2.value and not getLogicalSwitchValue(options.Switch1LS-0) and (menu.buttons[options.Config].taster2 >= 1) then
			LST[2] = t + menu.buttons[options.Config].taster2;
		end
		if (t > LST[2]) and (menu.buttons[options.Config].taster2 >= 1) then
			toggleButton2.value = false
		end
	end
    
	if menu.buttons[options.Config].taster3 then
		if toggleButton3.value and not getLogicalSwitchValue(options.Switch1LS+1) and (menu.buttons[options.Config].taster3 >= 1) then
			LST[3] = t + menu.buttons[options.Config].taster3;
		end
		if (t > LST[3]) and (menu.buttons[options.Config].taster3 >= 1) then
			toggleButton3.value = false
		end	
	end	
	
	if (menu.buttons[options.Config].taster4) then
		if toggleButton4.value and not getLogicalSwitchValue(options.Switch1LS+2) and (menu.buttons[options.Config].taster4 >= 1) then
			LST[4] = t + menu.buttons[options.Config].taster4;
		end
		if (t > LST[4]) and (menu.buttons[options.Config].taster4 >= 1) then
			toggleButton4.value = false
		end	
	end
	
	if (menu.buttons[options.Config].taster5) then
		if toggleButton5.value and not getLogicalSwitchValue(options.Switch1LS+3) and (menu.buttons[options.Config].taster5 >= 1) then
			LST[5] = t + menu.buttons[options.Config].taster5;
		end
		if (t > LST[5]) and (menu.buttons[options.Config].taster5 >= 1) then
			toggleButton5.value = false
		end
	end

	if (menu.buttons[options.Config].taster6) then
		if toggleButton6.value and not getLogicalSwitchValue(options.Switch1LS+4) and (menu.buttons[options.Config].taster6 >= 1) then
			LST[6] = t + menu.buttons[options.Config].taster6;
		end
		if (t > LST[6]) and (menu.buttons[options.Config].taster6 >= 1) then
			toggleButton6.value = false
		end	
	end

	if (menu.buttons[options.Config].taster7) then
		if toggleButton7.value and not getLogicalSwitchValue(options.Switch1LS+5) and (menu.buttons[options.Config].taster7 >= 1) then
			LST[7] = t + menu.buttons[options.Config].taster7;
		end
		if (t > LST[7]) and (menu.buttons[options.Config].taster7 >= 1) then
			toggleButton7.value = false
		end
	end

	if (menu.buttons[options.Config].taster8) then
		if toggleButton8.value and not getLogicalSwitchValue(options.Switch1LS+6) and (menu.buttons[options.Config].taster8 >= 1) then
			LST[8] = t + menu.buttons[options.Config].taster8;
		end
		if (t > LST[8]) and (menu.buttons[options.Config].taster8 >= 1) then
			toggleButton8.value = false
		end
	end
	----------------------------------------------------------------------------------------------------- Taster
	
end

-- Draw in widget mode
function libGUI.widgetRefresh()

end

-- This function is called from the refresh(...) function in the main script
function widget.refresh(event, touchState)
--print("TSwitch :refresh")
    if event == nil then
	--print("TSwitch :refresh auch gemacht")
		lcd.drawRectangle(0, 0, zone.w, zone.h, COLOR_THEME_EDIT)
		lcd.drawText(5, 2, menu.buttons[options.Config].name)
		--Button 0-3
		for variable = 0, 3 do	
			local lsname = "ls" .. options.Switch1LS + variable
			local v = getValue(lsname);
			if v > 0 then	
				lcd.drawFilledRectangle(  5, 22 + (variable*15), 90, 14, COLOR_THEME_ACTIVE)
			end
		end	
		--Button 4-7
		for variable = 4, 7 do	
			local lsname = "ls" .. options.Switch1LS + variable
			local v = getValue(lsname);
			if v > 0 then	
				lcd.drawFilledRectangle(  100, 22 + ((variable-4)*15), 90, 14, COLOR_THEME_ACTIVE)
			end
		end	
			
		lcd.drawText(  6, 21, menu.buttons[options.Config].button1,SMLSIZE)
		lcd.drawText(  6, 36, menu.buttons[options.Config].button2,SMLSIZE)
		lcd.drawText(  6, 51, menu.buttons[options.Config].button3,SMLSIZE)
		lcd.drawText(  6, 66, menu.buttons[options.Config].button4,SMLSIZE)
		lcd.drawText(101, 21, menu.buttons[options.Config].button5,SMLSIZE)
		lcd.drawText(101, 36, menu.buttons[options.Config].button6,SMLSIZE)
		lcd.drawText(101, 51, menu.buttons[options.Config].button7,SMLSIZE)
		lcd.drawText(101, 66, menu.buttons[options.Config].button8,SMLSIZE)
		UPDATE = false
        return
    end
	gui.run(event, touchState)
end

function widget.update(opt)
	options = opt
    for variable = -1, 6 do
		local ls = model.getLogicalSwitch(options.Switch1LS + variable);
			--set setLogicalSwitch to STICKY 
		if (ls.func ~= LS_FUNC_STICKY) then
			--model.setLogicalSwitch(options.Switch1LS + variable, {func = LS_FUNC_STICKY,v1 = 85 + options.Switch1LS + variable});
			model.setLogicalSwitch(options.Switch1LS + variable, {func = LS_FUNC_STICKY});
			setStickySwitch(options.Switch1LS + variable, false);
		end	
	end
end

-- Return to the create(...) function in the main script
return widget
