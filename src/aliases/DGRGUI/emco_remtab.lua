local tabName = matches[2]
local echo = wizzydizzy.helpers.echo
local chatEMCO = wizzydizzy.chat
local tabList = chatEMCO.consoles
if not table.contains(tabList, tabName) then
  echo(f"{tabName} does not exist to remove. Current tabs are: {table.concat(tabList, ', '}")
  return
end
chatEMCO:removeTab(tabName)