conky.config = {
  alignment = 'top_left',
  default_color = 'white',
  font = 'UbuntuMono Nerd Font:size=12',
  font2 = 'UbuntuMono Nerd Font:size=16',
  max_text_width = 0,
  minimum_width = 300,
  maximum_width = 300,
  out_to_wayland = true,
  own_window_transparent = true,
  update_interval = 1.0,
}

conky.text = [[
${font2}  System${font}
$hr
${execi 3600 nixos-version}
Kernel: ${alignr}${kernel}
EOL: ${alignr}${execpi 3600 bash -c 'source /etc/os-release; echo $SUPPORT_END'}
Uptime: ${alignr}${uptime_short}
]]
