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
${font2} Disks${font}
$hr
${font3}Maindisk${font}
Used: ${alignc}${fs_used /} / ${fs_size /} ${alignr}${fs_used_perc /}%
${fs_bar /}
Read: ${diskio_read /dev/sdb2}${alignr}Write: ${diskio_write /dev/sdb2}
${diskiograph_read /dev/sdb2 25,145}${offset 10}${diskiograph_write /dev/sdb2 25,145}

${font3}Datadisk${font}
Used: ${alignc}${fs_used /persist} / ${fs_size /persist} ${alignr}${fs_used_perc /persist}%
${fs_bar /persist}
Read: ${diskio_read /dev/sda1}${alignr}Write: ${diskio_write /dev/sda1}
${diskiograph_read /dev/sda1 25,145}${offset 10}${diskiograph_write /dev/sda1 25,145}
${if_match "${nodename}" == "P520"}
RAID status: ${alignr}${execi 3600 cat /proc/mdstat | grep -o '\[....\]'}
${endif}
${font3}Name ${alignr}IO${font}
${top_io name 1} ${alignr}${top_io io_perc 1}%
${top_io name 2} ${alignr}${top_io io_perc 2}%
${top_io name 3} ${alignr}${top_io io_perc 3}%
${top_io name 4} ${alignr}${top_io io_perc 4}%
${top_io name 5} ${alignr}${top_io io_perc 5}%
]]
