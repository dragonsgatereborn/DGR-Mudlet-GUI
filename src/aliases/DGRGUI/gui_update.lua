local currentVersion = "0.2.9"
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

cecho("<green>DGR GUI: <reset>Current version: " .. currentVersion .. "\n")
cecho("<green>DGR GUI: <reset>Updating from " .. repoUrl .. "\n")
cecho("<green>DGR GUI: <reset>Reinstalling package...\n")
local installComplete = false
local function afterInstall()
  if installComplete then return end
  installComplete = true
  enableGroups()
  if reloadPackage then
    reloadPackage("@PKGNAME@")
    cecho("<green>DGR GUI: <reset>Package reloaded.\n")
  end
  if DGRGUI and DGRGUI.start then
    DGRGUI.start()
  end
  cecho("<green>DGR GUI: <reset>Update complete (reinstalled latest).\n")
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

cecho("<green>DGR GUI: <reset>Update complete! Package installed from:\n")
cecho("<green>DGR GUI: <reset>" .. packageUrl .. "\n")
