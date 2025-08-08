conky.config = {
  alignment = 'top_left',
  default_color = 'white',
  font = 'UbuntuMono Nerd Font:size=12',
  max_text_width = 0,
  minimum_width = 300,
  maximum_width = 300,
  out_to_wayland = true,
  -- own_window_transparent = true,
  update_interval = 1.0,
}

conky.text = [[
${font UbuntuMono Nerd Font:pixelsize=20}  CPU${font}
$hr
Info: $sysname $nodename $kernel $machine
$hr
Uptime: $uptime
Frequency (in MHz): $freq
Frequency (in GHz): $freq_g
RAM Usage: $mem/$memmax - $memperc% ${membar 4}
Swap Usage: $swap/$swapmax - $swapperc% ${swapbar 4}
CPU Usage: $cpu% ${cpubar 4}
Processes: $processes  Running: $running_processes
$hr
File systems:
/ ${fs_used /}/${fs_size /} ${fs_bar 6 /}
Networking:
Up: ${upspeed}  - Down: ${downspeed}
$hr
Name              PID     CPU%   MEM%
${top name 1} ${top pid 1} ${top cpu 1} ${top mem 1}
${top name 2} ${top pid 2} ${top cpu 2} ${top mem 2}
${top name 3} ${top pid 3} ${top cpu 3} ${top mem 3}
${top name 4} ${top pid 4} ${top cpu 4} ${top mem 4}
]]
