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
  cfg = config.programs.terminal.opencode;
in
{
  options.programs.terminal.opencode = with types; {
    enable = mkBoolOpt false "enable opencode";
  };

  config = mkIf cfg.enable {
    home.programs.opencode = {
      enable = true;
      settings = {
        model = "groq/openai/gpt-oss-120b";
      };
    };
  };
}
