local repoUrl = "https://github.com/dragonsgatereborn/DGR-Mudlet-GUI"
local packageUrl = repoUrl .. "/releases/latest/download/@PKGNAME@.mpackage"

cecho("<green>EMCO Chat: <reset>Installing from " .. repoUrl .. "\n")
installPackage(packageUrl)
