{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ ];

  suites.common.enable = true;

  suites.social.enable = true;

  suites.development = {
    enable = true;
    dockerEnable = true;
    androidEnable = false;
    aiEnable = true;
  };

  suites.desktop = {
    enable = true;
  };

  # ======================== DO NOT CHANGE THIS ========================
  system.stateVersion = 5;
}
