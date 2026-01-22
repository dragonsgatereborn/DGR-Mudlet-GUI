DGRGUI = DGRGUI or {}

function DGRGUI.applyMainDisplayBorders()
  if setBorderTop then setBorderTop(150) end
  if setBorderBottom then setBorderBottom(150) end
  if setBorderLeft then setBorderLeft(500) end
  if setBorderRight then setBorderRight(500) end
end

DGRGUI.applyMainDisplayBorders()

if registerAnonymousEventHandler then
  if DGRGUI._mainDisplayBorderHandler and killAnonymousEventHandler then
    killAnonymousEventHandler(DGRGUI._mainDisplayBorderHandler)
  end
  DGRGUI._mainDisplayBorderHandler = registerAnonymousEventHandler("sysWindowResizeEvent", function()
    DGRGUI.applyMainDisplayBorders()
  end)
end
