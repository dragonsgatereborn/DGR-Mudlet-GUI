local repoUrl = "https://github.com/dragonsgatereborn/EMCO"
local packageUrl = repoUrl .. "/releases/latest/download/@PKGNAME@.mpackage"

cecho("<green>EMCO Chat: <reset>Installing from " .. repoUrl .. "\n")
installPackage(packageUrl)
