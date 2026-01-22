local repoUrl = "https://github.com/dragonsgatereborn/DGR-Mudlet-GUI"
local packageUrl = repoUrl .. "/releases/latest/download/@PKGNAME@.mpackage"

cecho("<green>DGR GUI: <reset>Restarting GUI (reinstalling package)...\n")
local installComplete = false
local function afterInstall()
  if installComplete then return end
  installComplete = true
  if reloadPackage then
    reloadPackage("@PKGNAME@")
  end
  if DGRGUI and DGRGUI.start then
    DGRGUI.start()
    cecho("<green>DGR GUI: <reset>Restart complete.\n")
  else
    cecho("<green>DGR GUI: <reset>Restart complete (start() not available yet).\n")
  end
end

if registerAnonymousEventHandler then
  local handler
  handler = registerAnonymousEventHandler("sysInstall", function(_, pkg)
    if pkg == "@PKGNAME@" then
      killAnonymousEventHandler(handler)
      tempTimer(0.5, afterInstall)
    end
  end)
end

uninstallPackage("@PKGNAME@")
installPackage(packageUrl)
tempTimer(2, afterInstall)
