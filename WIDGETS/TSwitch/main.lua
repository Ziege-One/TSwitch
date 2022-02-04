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
local name = "TSwitch"
local libgui

-- Return GUI library table
function loadGUI()
  if not libgui then
  -- Loadable code chunk is called immediately and returns TSwitch
  	libgui = loadScript("/WIDGETS/" .. name .. "/libgui.lua")
  end
  
  return libgui()
end

---------------------------------------------------------------------------
-- The following widget implementation demonstrates how to use the       --
-- library and how to create a dynamically loadable widget to minimize   --
-- the amount of memory consumed when the widget is not being used.      --
-- You do not need to run the widget to use the library.                 --
---------------------------------------------------------------------------

local function create(zone, options)
  -- Loadable code chunk is called immediately and returns a widget table
  return loadScript("/WIDGETS/" .. name .. "/loadable.lua")(zone, options)
end

local function refresh(widget, event, touchState)
  widget.refresh(event, touchState)
end

local function background(widget)
end

local options = {
  { "Switch1LS", VALUE, 30, 1, 64 },
  { "Config", VALUE, 1, 1, 10 }  
}

local function update(widget, options)
  widget.update(options)
end

return {
  name = name,
  create = create,
  refresh = refresh,
  background = background,
  options = options,
  update = update
}