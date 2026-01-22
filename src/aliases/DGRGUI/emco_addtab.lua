local tabName = matches[2]
local pos = tonumber(matches[3])
local echo = wizzydizzy.helpers.echo
local chatEMCO = wizzydizzy.chat

if table.contains(chatEMCO.consoles, tabName) then
  echo(f"{tabName} already exists!")
  return
end
chatEMCO:addTab(tabName, pos)