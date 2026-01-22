local repoUrl = "https://github.com/dragonsgatereborn/DGR-Mudlet-GUI"
local packageUrl = repoUrl .. "/releases/latest/download/@PKGNAME@.mpackage"

cecho("<green>DGR GUI: <reset>Installing from " .. repoUrl .. "\n")
local installComplete = false
local function afterInstall()
  if installComplete then return end
  installComplete = true
  if reloadPackage then
    reloadPackage("@PKGNAME@")
    cecho("<green>DGR GUI: <reset>Package reloaded.\n")
  end
  if DGRGUI and DGRGUI.start then
    DGRGUI.start()
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
