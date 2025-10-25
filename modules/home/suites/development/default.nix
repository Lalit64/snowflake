{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.suites.development;
in
{
  options.suites.development = with types; {
    enable = mkBoolOpt false "enable development suite";
    aiEnable = mkBoolOpt false "enable ai development";
  };

  config = mkIf cfg.enable {
    programs = {
      graphical = {
        editors = {
          vscode = {
            enable = true;
          };
        };
      };

      terminal = {
        tools = {
          television.enable = true;
          mise-en-place.enable = true;
          opencode.enable = if cfg.aiEnable then true else false;
        };
      };
    };
  };
}
