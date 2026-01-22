local echo = echo or cecho

if DGRGUI and DGRGUI.restart then
  DGRGUI.restart()
  if echo then
    echo("DGRGUI: restart complete.\n")
  end
else
  if echo then
    echo("DGRGUI: restart not available. Try reinstalling the package.\n")
  end
end
