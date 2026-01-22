local repoUrl = "https://github.com/dragonsgatereborn/DGR-Mudlet-GUI"
local packageUrl = repoUrl .. "/releases/latest/download/@PKGNAME@.mpackage"

local function enableGroups()
  if enablePackage then
    enablePackage("@PKGNAME@")
  end
  if enableAliasGroup then
    enableAliasGroup("@PKGNAME@")
  end
  if enableTriggerGroup then
    enableTriggerGroup("@PKGNAME@")
  end
  if enableScriptGroup then
    enableScriptGroup("@PKGNAME@")
  end
end

cecho("<green>DGR GUI: <reset>Restarting GUI (reinstalling package)...\n")
local installComplete = false
local function afterInstall()
  if installComplete then return end
  installComplete = true
  enableGroups()
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
tempTimer(0.5, function()
  installPackage(packageUrl)
end)
tempTimer(3, afterInstall)
