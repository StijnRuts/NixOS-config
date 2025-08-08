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
${font2}  Network${font}
$hr
Hostname: ${alignr}${nodename}
Interface: ${alignr}${gw_iface}
Quality: ${alignr}${wireless_link_qual_perc ${gw_iface}}%
Address: ${alignr}${addr ${gw_iface}}
Gateway: ${alignr}${gw_ip}
Nameserver: ${alignr}${nameserver}
Up / Down: ${alignr}${upspeed ${gw_iface}} / ${downspeed ${gw_iface}}
${upspeedgraph ${gw_iface} 25,145} ${downspeedgraph ${gw_iface} 25,145}
]]
