cecho("<green>DGR GUI: <reset>Restarting GUI...\n")
if DGRGUI and DGRGUI.start then
  DGRGUI.start()
  cecho("<green>DGR GUI: <reset>Restart complete.\n")
else
  cecho("<green>DGR GUI: <reset>No start() found yet. Nothing to restart.\n")
end
