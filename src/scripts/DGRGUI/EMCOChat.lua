-- EMCO Chatbox for DGR GUI (right border)
local defaultConfig = {activeColor = "black", inactiveColor = "black", activeBorder = "green", activeText = "green", inactiveText = "grey", background = "black", windowBorder = "green", title = "green"}
local emco = require("@PKGNAME@.emco")

emco.cmdLineStyleSheet = nil
wizzydizzy = wizzydizzy or {}
wizzydizzy.helpers = wizzydizzy.helpers or {}
wizzydizzy.config = wizzydizzy.config or defaultConfig

local baseStyle = Geyser.StyleSheet:new(f [[
  border-width: 2px; 
  border-style: solid; 
]])
local activeStyle = Geyser.StyleSheet:new(f [[
  border-color: {wizzydizzy.config.activeBorder};
  background-color: {wizzydizzy.config.activeColor};
]], baseStyle)
local inactiveStyle = Geyser.StyleSheet:new(f [[
  border-color: {wizzydizzy.config.inactiveColor};
  background-color: {wizzydizzy.config.inactiveColor};
]], baseStyle)

local chatContainer = Geyser.Container:new({
  name = "DGRGUI_EMCOContainer",
  x = "-500",
  y = 300,
  width = 500,
  height = "-600",
})

local chatEMCO = wizzydizzy.chat
local confFile = getMudletHomeDir() .. "/DGRGUI/EMCOChatConfig.lua"

function wizzydizzy.helpers.echo(msg)
  msg = msg or ""
  cecho(f "<green>EMCO Chat: <reset>{msg}\n")
end

function wizzydizzy.helpers.resetToDefaults()
  wizzydizzy.config = defaultConfig
  wizzydizzy.chat = emco:new({
    name = "DGRGUI_EMCO",
    x = 0,
    y = 0,
    height = "100%",
    width = "100%",
    consoles = {"All", "Program", "OOC", "RP", "Whisper", "Group", "Game"},
    allTab = true,
    allTabName = "All",
    blankLine = true,
    blink = true,
    bufferSize = 10000,
    deleteLines = 500,
    timestamp = true,
    fontSize = 14,
    tabFontSize = 16,
    font = "Ubuntu Mono",
    consoleColor = wizzydizzy.config.background,
    activeTabCSS = activeStyle:getCSS(),
    inactiveTabCSS = inactiveStyle:getCSS(),
    activeTabFGColor = wizzydizzy.config.activeText,
    inactiveTabFGColor = wizzydizzy.config.inactiveText,
    gap = 3,
    commandLine = true,
  }, chatContainer)
  chatEMCO = wizzydizzy.chat
  wizzydizzy.helpers.retheme()
end

function wizzydizzy.helpers.retheme()
  activeStyle:set("background-color", wizzydizzy.config.activeColor)
  activeStyle:set("border-color", wizzydizzy.config.activeBorder)
  inactiveStyle:set("background-color", wizzydizzy.config.inactiveColor)
  inactiveStyle:set("border-color", wizzydizzy.config.inactiveColor)
  chatEMCO.activeTabCSS = activeStyle:getCSS()
  chatEMCO.inactiveTabCSS = inactiveStyle:getCSS()
  chatEMCO:setActiveTabFGColor(wizzydizzy.config.activeText)
  chatEMCO:setInactiveTabFGColor(wizzydizzy.config.inactiveText)
  chatEMCO:setConsoleColor(wizzydizzy.config.background)
  chatEMCO:switchTab(chatEMCO.currentTab)
end

function wizzydizzy.helpers.save()
  if chatEMCO and chatEMCO.save then
    chatEMCO:save()
  end
  table.save(confFile, wizzydizzy.config)
end

function wizzydizzy.helpers.load()
  if io.exists(confFile) then
    local conf = {}
    table.load(confFile, conf)
    wizzydizzy.config = table.update(wizzydizzy.config, conf)
    for option, value in pairs(defaultConfig) do
      wizzydizzy.config[option] = wizzydizzy.config[option] or value
    end
  end
  wizzydizzy.helpers.retheme()
end

local function startup()
  wizzydizzy.helpers.resetToDefaults()
  wizzydizzy.helpers.load()
end

startup()
