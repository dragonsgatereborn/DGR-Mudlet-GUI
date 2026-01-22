local echo = wizzydizzy.helpers.echo
local ok, err = wizzydizzy.helpers.setConfig(matches[2], matches[3])

if not ok then
  echo(err)
  return
end
echo(f"Set color for {matches[2]} to {matches[3]}")