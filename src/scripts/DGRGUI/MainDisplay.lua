DGRGUI = DGRGUI or {}

local function getBackgroundPath()
  local profile = getProfileName and getProfileName() or ""
  local base = getMudletHomeDir and getMudletHomeDir() or ""
  if profile ~= "" and base ~= "" then
    return base .. "/profiles/" .. profile .. "/DGRGUI/dgrgui_background.png"
  end
  return nil
end

function DGRGUI.applyBackground()
  local path = getBackgroundPath()
  if path and setBackgroundImage then
    setBackgroundImage(path, "scaled")
  end
end

function DGRGUI.applyMainDisplayBorders()
  if setBorderTop then setBorderTop(150) end
  if setBorderBottom then setBorderBottom(150) end
  if setBorderLeft then setBorderLeft(500) end
  if setBorderRight then setBorderRight(500) end
end

DGRGUI.applyMainDisplayBorders()
DGRGUI.applyBackground()

if registerAnonymousEventHandler then
  if DGRGUI._mainDisplayBorderHandler and killAnonymousEventHandler then
    killAnonymousEventHandler(DGRGUI._mainDisplayBorderHandler)
  end
  DGRGUI._mainDisplayBorderHandler = registerAnonymousEventHandler("sysWindowResizeEvent", function()
    DGRGUI.applyMainDisplayBorders()
    DGRGUI.applyBackground()
  end)
end
