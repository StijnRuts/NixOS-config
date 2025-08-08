conky.config = {
  alignment = 'top_left',
  default_color = 'white',
  font = 'UbuntuMono Nerd Font:size=12',
  font2 = 'UbuntuMono Nerd Font:size=16',
  font3 = 'UbuntuMono Nerd Font:bold:size=12',
  max_text_width = 0,
  minimum_width = 300,
  maximum_width = 300,
  out_to_wayland = true,
  own_window_transparent = true,
  update_interval = 1.0,
}

conky.text = [[
${font2}  Memory${font}
$hr
Used: ${alignc}${mem} / ${memmax} ${alignr}${memperc}%
${membar}
${memgraph}
Swap: ${alignc}${swap} / ${swapmax} ${alignr}${swapperc}%
${swapbar}

${font3}Name ${alignr}Memory${font}
${top_mem name 1} ${alignr}${top_mem mem 1}%
${top_mem name 2} ${alignr}${top_mem mem 2}%
${top_mem name 3} ${alignr}${top_mem mem 3}%
${top_mem name 4} ${alignr}${top_mem mem 4}%
${top_mem name 5} ${alignr}${top_mem mem 5}%
]]
