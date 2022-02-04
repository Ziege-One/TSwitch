---------------------------------------------------------------------------
-- TSwitch                                                               --
--                                                                       --
-- Author:  DerRCModellbauer                                             --
-- Original Author:  Jesper Frickmann                                    --
-- Date:    2022-01-16                                                   --
-- Version: 0.1                                                          --
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



local menu = {
    buttons = {
        {name = "Beleuchtung1", button1 = "Licht11", button2 = "Licht12", button3 = "Licht13", button4 = "Licht14", button5 = "Licht15", button6 = "Licht17", button7 = "Licht17", button8 = "Licht18"},
        {name = "Beleuchtung2", button1 = "Licht21", button2 = "Licht22", button3 = "Licht23", button4 = "Licht24", button5 = "Licht25", button6 = "Licht27", button7 = "Licht27", button8 = "Licht28"},
        {name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
        {name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
        {name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
        {name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
		{name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
		{name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
		{name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
		{name = "Licht", button1 = "1", button2 = "2", button3 = "3", button4 = "4", button5 = "5", button6 = "7", button7 = "7", button8 = "8"},
	}	
    
}

local zone, options = ... --zone and options were passed as arguments to chunk(...).
local widget = { } -- The widget table will be returned to the main script.

-- Load the GUI library by calling the global function declared in the main script.
-- As long as TSwitch is on the SD card, any widget can call loadGUI() because it is global.
local TSwitch = loadGUI()
TSwitch.flags = MIDSIZE -- Default flags that are used unless other flags are passed.
local gui = TSwitch.newGUI() -- Instantiate a new GUI object.

-- Local constants and variables:
local LEFT = 20
local TOP = 10
local COL = 160
local ROW = 80
local WIDTH = 120
local HEIGHT = 60

-- Called by gui in full screen mode
local function drawFull()
   print("drawFull");

end

local function getls(switch)
--print("LS : " .. switch);
  if getValue("ls"..switch)== 1024 then
  --if getLogicalSwitchValue(switch-1) then
    --print(" -true ");
	return true 
  else
    --print(" -false ");
	return false
  end
end
  
-- Called by gui in widget zone mode
local function drawZone()
 print("drawZone");
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
  --lcd.drawText(135, 65, tostring(Buttonstate1),SMLSIZE)
end

-- Call back for toggle button
local function doToggle1(toggleButton)
  local ls = options.Switch1LS
  if toggleButton.value then
	model.setLogicalSwitch(ls-1, {func=3,v1=100,v2=0})
	--setStickySwitch(ls-1, true)     -- Test für egdeTX 2.6
  else
	model.setLogicalSwitch(ls-1, {func=1,v1=100,v2=0})
	--setStickySwitch(ls-1, false)    -- Test für egdeTX 2.6
  end
end

-- Call back for toggle button
local function doToggle2(toggleButton)
  local ls = options.Switch1LS
  if toggleButton.value then
	model.setLogicalSwitch(ls, {func=3,v1=100,v2=0})
  else
	model.setLogicalSwitch(ls, {func=1,v1=100,v2=0})
  end
end

-- Call back for toggle button
local function doToggle3(toggleButton)
  local ls = options.Switch1LS
  if toggleButton.value then
	model.setLogicalSwitch(ls+1, {func=3,v1=100,v2=0})
  else
	model.setLogicalSwitch(ls+1, {func=1,v1=100,v2=0})
  end
end

-- Call back for toggle button
local function doToggle4(toggleButton)
  local ls = options.Switch1LS
  if toggleButton.value then
	model.setLogicalSwitch(ls+2, {func=3,v1=100,v2=0})
  else
	model.setLogicalSwitch(ls+2, {func=1,v1=100,v2=0})
  end
end

-- Call back for toggle button
local function doToggle5(toggleButton)
  local ls = options.Switch1LS
  if toggleButton.value then
	model.setLogicalSwitch(ls+3, {func=3,v1=100,v2=0})
  else
	model.setLogicalSwitch(ls+3, {func=1,v1=100,v2=0})
  end
end

-- Call back for toggle button
local function doToggle6(toggleButton)
  local ls = options.Switch1LS
  if toggleButton.value then
	model.setLogicalSwitch(ls+4, {func=3,v1=100,v2=0})
  else
	model.setLogicalSwitch(ls+4, {func=1,v1=100,v2=0})
  end
end

-- Call back for toggle button
local function doToggle7(toggleButton)
  local ls = options.Switch1LS
  if toggleButton.value then
	model.setLogicalSwitch(ls+5, {func=3,v1=100,v2=0})
  else
	model.setLogicalSwitch(ls+5, {func=1,v1=100,v2=0})
  end
end

-- Call back for toggle button
local function doToggle8(toggleButton)
  local ls = options.Switch1LS
  if toggleButton.value then
	model.setLogicalSwitch(ls+6, {func=3,v1=100,v2=0})
  else
	model.setLogicalSwitch(ls+6, {func=1,v1=100,v2=0})
  end
end

-- Call back for EXIT button
local function exitFS()
  lcd.exitFullScreen()
end

do -- Initialization happens here
  local x = LEFT
  local y = TOP
  
  local function nextCol()
    x = x + COL
  end
  
  local function nextRow()
    x = LEFT
    y = y + ROW
  end
  
  gui.widgetRefresh = drawZone
  gui.fullScreenRefresh = drawFull
  
  gui.toggleButton(x, y, WIDTH, HEIGHT, menu.buttons[options.Config].button1, getls(options.Switch1LS), doToggle1)
  nextCol()
  gui.toggleButton(x, y, WIDTH, HEIGHT, menu.buttons[options.Config].button2, getls(options.Switch1LS+1), doToggle2)
  nextCol()
  gui.toggleButton(x, y, WIDTH, HEIGHT, menu.buttons[options.Config].button3, getls(options.Switch1LS+2), doToggle3)
  nextRow()
  gui.toggleButton(x, y, WIDTH, HEIGHT, menu.buttons[options.Config].button4, getls(options.Switch1LS+3), doToggle4)
  nextCol()
  gui.toggleButton(x, y, WIDTH, HEIGHT, menu.buttons[options.Config].button5, getls(options.Switch1LS+4), doToggle5)
  nextCol()
  gui.toggleButton(x, y, WIDTH, HEIGHT, menu.buttons[options.Config].button6, getls(options.Switch1LS+5), doToggle6)
  nextRow()
  gui.toggleButton(x, y, WIDTH, HEIGHT, menu.buttons[options.Config].button7, getls(options.Switch1LS+6), doToggle7)
  nextCol()
  gui.toggleButton(x, y, WIDTH, HEIGHT, menu.buttons[options.Config].button8, getls(options.Switch1LS+7), doToggle8)
  nextCol()
  gui.button(x, y, WIDTH, HEIGHT, "EXIT", exitFS)

end

-- This function is called from the refresh(...) function in the main script
function widget.refresh(event, touchState)
  gui.run(event, touchState)
end

function widget.update(opt)
  options = opt
end

-- Return to the create(...) function in the main script
return widget
