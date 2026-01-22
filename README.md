# DGR Mudlet GUI

Base Mudlet GUI package for Dragons Gate Reborn.

This package includes the EMCO core plus a prebuilt chatbox inside the right border. It also ships example triggers you can copy into your own packages.

Author: WizzyDizzy  
Contributor: WizzyDizzy

## Install

```lua
lua uninstallPackage("DGRGUI")
lua installPackage("https://github.com/dragonsgatereborn/DGR-Mudlet-GUI/releases/latest/download/DGRGUI.mpackage")
```

## Notes

- Do not add or change anything inside the DGRGUI package folders in Mudlet.
- Updates overwrite package contents and will remove local edits.
- Put your custom work in a separate package or outside the DGRGUI package.

## EMCO

EMCO is included as part of this package. You can access it with:

```lua
local emco = require("DGRGUI.emco")
```

## Commands

GUI management commands:

- `gui update`
- `gui restart`
- `gui install`
- `gui uninstall`
- `gui version`

EMCO commands:

- `emco addtab <tabname>`
- `emco addFontSize <size>`
- `emco blankLine <true|false>`
- `emco blink <true|false>`
- `emco color <option> <value>`
- `emco font <fontname>`
- `emco fontSize <size>`
- `emco tabFontSize <size>`
- `emco gag <pattern>`
- `emco gaglist`
- `emco hide`
- `emco load`
- `emco lock`
- `emco notify <tabname>`
- `emco remtab <tabname>`
- `emco restart`
- `emco save`
- `emco show`
- `emco timestamp <true|false>`
- `emco title <new title>`
- `emco ungag <pattern>`
- `emco unlock`
- `emco unnotify <tabname>`
- `emco update`
- `emco install`
- `emco uninstall`
- `emco version`

## Default EMCO Tabs

`All`, `Program`, `OOC`, `RP`, `Whisper`, `Group`, `Game`

## Example Triggers

Example triggers are included for each tab in the Trigger folder. Copy them into your own package and change the patterns to match your game's output.
