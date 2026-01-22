DGRGUI = DGRGUI or {}
DGRGUI.modules = DGRGUI.modules or {}

local function safe_call(label, fn)
  if type(fn) == "function" then
    local ok, err = pcall(fn)
    if not ok then
      if cecho then
        cecho("<red>DGRGUI: " .. label .. " failed: " .. tostring(err) .. "\n")
      end
    end
  end
end

function DGRGUI.restart()
  -- Re-apply borders/background if available
  safe_call("applyMainDisplayBorders", DGRGUI.applyMainDisplayBorders)
  safe_call("applyBackground", DGRGUI.applyBackground)

  -- Restart EMCO chat container if present
  if demonnic and demonnic.helpers then
    safe_call("emco resetToDefaults", demonnic.helpers.resetToDefaults)
    safe_call("emco load", demonnic.helpers.load)
  end

  -- Restart any registered modules
  for name, mod in pairs(DGRGUI.modules) do
    if type(mod) == "table" and type(mod.restart) == "function" then
      safe_call("module " .. tostring(name) .. " restart", mod.restart)
    end
  end
end

-- Run once on load so base GUI state is applied
DGRGUI.restart()
