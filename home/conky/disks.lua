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
${font2} Disks${font}
$hr
${font3}Maindisk${font}
Used: ${alignc}${fs_used /} / ${fs_size /} ${alignr}${fs_used_perc /}%
${fs_bar /}
Read / Write: ${alignr}${diskio_read /dev/sdb2} / ${diskio_write /dev/sdb2}
${diskiograph_read /dev/sdb2 25,145} ${diskiograph_write /dev/sdb2 25,145}

${font3}Datadisk${font}
Used: ${alignc}${fs_used /persist} / ${fs_size /persist} ${alignr}${fs_used_perc /persist}%
${fs_bar /persist}
Read / Write: ${alignr}${diskio_read /dev/sda1} / ${diskio_write /dev/sda1}
${diskiograph_read /dev/sda1 25,145} ${diskiograph_write /dev/sda1 25,145}

${font3}Name ${alignr}IO${font}
${top_io name 1} ${alignr}${top_io io_perc 1}%
${top_io name 2} ${alignr}${top_io io_perc 2}%
${top_io name 3} ${alignr}${top_io io_perc 3}%
${top_io name 4} ${alignr}${top_io io_perc 4}%
${top_io name 5} ${alignr}${top_io io_perc 5}%
]]
