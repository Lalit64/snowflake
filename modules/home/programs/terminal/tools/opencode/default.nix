{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.tools.opencode;
in
{
  options.programs.terminal.tools.opencode = with types; {
    enable = mkBoolOpt false "enable opencode";
  };

  config = mkIf cfg.enable {
    programs.opencode = {
      enable = true;
      settings = {
        model = "groq/openai/gpt-oss-120b";
      };
    };
  };
}
