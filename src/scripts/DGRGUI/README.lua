--[[
DGR Mudlet GUI

Base package with EMCO included.

Author: WizzyDizzy
Contributor: WizzyDizzy

Install
- lua uninstallPackage("DGRGUI")
- lua installPackage("https://github.com/dragonsgatereborn/DGR-Mudlet-GUI/releases/latest/download/DGRGUI.mpackage")

Commands
- gui install
- gui uninstall
- gui update
- gui restart
- gui version
- emco update
- emco restart
- emco version

Layout
- Main display area is centered with 500px left/right borders and 200px top/bottom borders

Notes
- Do not add or change anything inside DGRGUI package folders.
- Updates overwrite package contents and remove local edits.

EMCO
- local emco = require("DGRGUI.emco")
- DGRGUI.emco is initialized on startup
- EMCO chatbox is initialized inside the right border
- Default tabs: All, Program, OOC, RP, Whisper, Group, Game

Example Triggers
- Example triggers are included for each tab in the Trigger folder
--]]
