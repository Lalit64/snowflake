{
  options,
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.graphical.karabiner;
in
{
  options.programs.graphical.karabiner = with types; {
    enable = mkBoolOpt false "enable karabiner-elements";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [
      "karabiner-elements"
    ];

    home.file."/Users/${config.user.name}/.config/karabiner/karabiner.json".source = ./karabiner.json;
  };
}
