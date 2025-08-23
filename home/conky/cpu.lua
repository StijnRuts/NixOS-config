conky.config = {
  alignment = 'top_left',
  default_color = 'white',
  font = os.getenv("CONKY_FONT")..':size=12',
  font2 = os.getenv("CONKY_FONT")..':size=16',
  font3 = os.getenv("CONKY_FONT")..':bold:size=12',
  max_text_width = 0,
  minimum_width = 300,
  maximum_width = 300,
  out_to_wayland = true,
  own_window_transparent = true,
  update_interval = 1.0,
}

conky.text = [[
${font2}  CPU${font}
$hr
CPU: ${alignr}${cpu cpu0}%
Frequency: ${alignr}${freq}MHz
${cpugraph}
${execpi 60 ~/NixOS/home/conky/cpu_bars.sh}

${font3}Name ${alignr}CPU${font}
${top name 1} ${alignr}${top cpu 1}%
${top name 2} ${alignr}${top cpu 2}%
${top name 3} ${alignr}${top cpu 3}%
${top name 4} ${alignr}${top cpu 4}%
${top name 5} ${alignr}${top cpu 5}%
]]
