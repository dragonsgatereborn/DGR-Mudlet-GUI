--[[
DGR Mudlet GUI

Base package with EMCO included (no GUI scripts yet).

Author: WizzyDizzy
Contributor: WizzyDizzy

Install
- lua installPackage("https://github.com/dragonsgatereborn/DGR-Mudlet-GUI/releases/latest/download/DGRGUI.mpackage")

Commands
- gui install
- gui uninstall
- gui update
- gui restart
- gui version

Layout
- Main display area is centered with 300px margins on left/right

Notes
- Do not add or change anything inside DGRGUI package folders.
- Updates overwrite package contents and remove local edits.

EMCO
- local emco = require("DGRGUI.emco")
- DGRGUI.emco is initialized on startup
- EMCO chatbox is initialized inside the right border
--]]
