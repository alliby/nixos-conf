{ ... }:
{
  services.upower.enable = true;
  services.upower = { 
    percentageCritical = 20;
    percentageAction = 20;
  };
}
