local echo = wizzydizzy.helpers.echo

if wizzydizzy.container then
  if wizzydizzy.container.hide then
    wizzydizzy.container:hide()
  end
  if wizzydizzy.container.close then
    wizzydizzy.container:close()
  end
  if wizzydizzy.container.destroy then
    wizzydizzy.container:destroy()
  end
end

wizzydizzy.container = nil
wizzydizzy.chat = nil
collectgarbage("collect")

wizzydizzy.helpers.resetToDefaults()
echo("Restarted EMCO chat window.")
