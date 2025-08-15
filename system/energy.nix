{
  config,
  pkgs,
  lib,
  isLaptop,
  ...
}:
(lib.optionalAttrs isLaptop {
  services.power-profiles-daemon.enable = false; # in favor of tlp

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "ondemand";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;

      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  /*
    CPU_SCALING_GOVERNOR
      powersave: default, Always targets the lowest possible CPU frequency to minimize power consumption. Best for maximum battery life when system load is light
      performance: Maintains maximum CPU frequency at all times. Highest power consumption but fastest response times. Best for demanding tasks requiring consistent high performance
      ondemand: default on most distributions, Dynamically adjusts CPU frequency based on current workload. Quickly scales up when needed and down when idle. Provides good balance between performance and power savings
      conservative: Similar to ondemand but with slower scaling, prioritizing stability over quick responses. Good for predictable workloads
      userspace: Allows manual control of CPU frequencies through user-space programs. Requires external utilities to manage frequency scaling
      schedutil: default for newer kernel, Uses the kernel's scheduler utilization data to make informed decisions about CPU frequency. Modern approach that adapts well to varying workloads

    CPU_ENERGY_PERF_POLICY
      performance: Prioritizes processing speed over power efficiency. Best for demanding tasks requiring maximum performance
      balance_performance: Slightly favors performance while allowing some power saving opportunities
      default: System default balance point between performance and power efficiency
      balance_power: Slightly favors power saving while maintaining reasonable performance levels
      power: Maximizes power saving at the cost of processing speed. Best for extending battery life during low-intensity tasks
  */
})
