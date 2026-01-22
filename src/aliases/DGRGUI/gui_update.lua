local currentVersion = "0.2.1"
local repoUrl = "https://github.com/dragonsgatereborn/DGR-Mudlet-GUI"
local packageUrl = repoUrl .. "/releases/latest/download/@PKGNAME@.mpackage"

cecho("<green>DGR GUI: <reset>Current version: " .. currentVersion .. "\n")
cecho("<green>DGR GUI: <reset>Updating from " .. repoUrl .. "\n")
cecho("<green>DGR GUI: <reset>Installing latest package...\n")
installPackage(packageUrl)
cecho("<green>DGR GUI: <reset>Update complete (installed latest).\n")

cecho("<green>DGR GUI: <reset>Update complete! Package installed from:\n")
cecho("<green>DGR GUI: <reset>" .. packageUrl .. "\n")
