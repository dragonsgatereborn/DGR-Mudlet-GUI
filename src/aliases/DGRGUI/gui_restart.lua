local repoUrl = "https://github.com/dragonsgatereborn/DGR-Mudlet-GUI"
local packageUrl = repoUrl .. "/releases/latest/download/@PKGNAME@.mpackage"

cecho("<green>DGR GUI: <reset>Restarting GUI (reinstalling package)...\n")
uninstallPackage("@PKGNAME@")
installPackage(packageUrl)

if DGRGUI and DGRGUI.start then
  DGRGUI.start()
  cecho("<green>DGR GUI: <reset>Restart complete.\n")
else
  cecho("<green>DGR GUI: <reset>Restart complete (start() not available yet).\n")
end
