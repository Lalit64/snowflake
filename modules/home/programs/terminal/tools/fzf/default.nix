{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.tools.fzf;
in
{
  options.programs.terminal.tools.fzf = with types; {
    enable = mkBoolOpt false "enable fzf";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [
        ''--border="none"''
        ''--border-label=""''
        ''--prompt="❯" ''
        ''--marker="󰅂"''
        ''--pointer="󰅂"''
        ''--separator "─"''
        ''--scrollbar="│"''
        ''--layout="reverse"''
        ''--info="right"''
      ];
    };
  };
}
