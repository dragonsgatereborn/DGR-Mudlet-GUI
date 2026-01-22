DGRGUI = DGRGUI or {}
-- Load EMCO module from this package
DGRGUI.emco = require("DGRGUI.emco")
require("DGRGUI.EMCOChat")

local function safeDestroy(container)
  if not container then return end
  if container.hide then container:hide() end
  if container.close then container:close() end
  if container.destroy then container:destroy() end
end

function DGRGUI.enableGroups()
  if enablePackage then
    enablePackage("DGRGUI")
  end
  if enableAliasGroup then
    enableAliasGroup("DGRGUI")
  end
  if enableTriggerGroup then
    enableTriggerGroup("DGRGUI")
  end
  if enableScriptGroup then
    enableScriptGroup("DGRGUI")
  end
end

function DGRGUI.start()
  DGRGUI.enableGroups()
  if setBorderLeft then setBorderLeft(500) end
  if setBorderRight then setBorderRight(500) end
  if setBorderTop then setBorderTop(200) end
  if setBorderBottom then setBorderBottom(200) end
end

if registerAnonymousEventHandler then
  if DGRGUI._resizeHandler then
    killAnonymousEventHandler(DGRGUI._resizeHandler)
  end
  DGRGUI._resizeHandler = registerAnonymousEventHandler("sysWindowResizeEvent", function()
    if setBorderLeft then setBorderLeft(500) end
    if setBorderRight then setBorderRight(500) end
    if setBorderTop then setBorderTop(200) end
    if setBorderBottom then setBorderBottom(200) end
  end)
end

DGRGUI.start()
tempTimer(1, function()
  if DGRGUI and DGRGUI.enableGroups then
    DGRGUI.enableGroups()
  end
end)
