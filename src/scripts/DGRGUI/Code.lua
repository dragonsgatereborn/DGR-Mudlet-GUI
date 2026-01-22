DGRGUI = DGRGUI or {}
-- Load EMCO module from this package
DGRGUI.emco = require("DGRGUI.emco")

local function safeDestroy(container)
  if not container then return end
  if container.hide then container:hide() end
  if container.close then container:close() end
  if container.destroy then container:destroy() end
end

function DGRGUI.start()
  safeDestroy(DGRGUI.mainContainer)

  if setBorderLeft then setBorderLeft(300) end
  if setBorderRight then setBorderRight(300) end

  DGRGUI.mainContainer = Geyser.Container:new({
    name = "DGRGUI_Main",
    x = 300,
    y = 0,
    width = "-600",
    height = "100%",
  })

  DGRGUI.mainLabel = Geyser.Label:new({
    name = "DGRGUI_MainLabel",
    x = 0,
    y = 0,
    width = "100%",
    height = "100%",
  }, DGRGUI.mainContainer)

  DGRGUI.mainLabel:setStyleSheet([[background-color: rgba(0,0,0,20%); border: 1px solid #3a3a3a;]])
end

if registerAnonymousEventHandler then
  if DGRGUI._resizeHandler then
    killAnonymousEventHandler(DGRGUI._resizeHandler)
  end
  DGRGUI._resizeHandler = registerAnonymousEventHandler("sysWindowResizeEvent", function()
    if setBorderLeft then setBorderLeft(300) end
    if setBorderRight then setBorderRight(300) end
  end)
end

DGRGUI.start()
