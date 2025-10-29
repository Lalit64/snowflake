{ ... }:
{
  suites.common.enable = true;
  suites.development = {
    enable = true;
    aiEnable = true;
  };

  theme.stylix = {
    enable = true;
    theme = "gruvbox-dark-hard";
  };
  # theme.tokyonight-moon.enable = true;
  # theme.catppuccin-mocha.enable = true;

  home.stateVersion = "24.11";
}
