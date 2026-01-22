# DGR Mudlet GUI

Base Mudlet GUI package for Dragons Gate Reborn.

This package includes the EMCO core (emco.lua + dependencies) but no chatbox scripts/aliases/triggers yet. We will build the GUI on top of this repository.

Author: Demonnic  
Contributor: WizzyDizzy

## Install

```lua
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

Base management commands (no GUI/chat features yet):

- `gui update`
- `gui restart`
- `gui version`
