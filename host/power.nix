{...}: {

  # system will go from suspend into hibernate after 1 hour
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
  '';  
  
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 70;

      # Optional helps save long term battery health
      STOP_CHARGE_THRESH_BAT0 = 95; # 95 and above it stops charging
    };
  };

  # UPower
  services.upower = {
    enable = true;
    usePercentageForPolicy = true;
    percentageAction = 10;
  };

}
