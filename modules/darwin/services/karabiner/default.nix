{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.services.karabiner;
in
{
  options.services.karabiner = with types; {
    enable = mkBoolOpt false "enable karabiner-elements";
  };

  config = mkIf cfg.enable {
    ${namespace}.home.file."/Users/${config.user.name}/.config/karabiner/karabiner.json".source =
      ./karabiner.json;
  };
}
