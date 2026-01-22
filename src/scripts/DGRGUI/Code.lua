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

DGRGUI.start()
