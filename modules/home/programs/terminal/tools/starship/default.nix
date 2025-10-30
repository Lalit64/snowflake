{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.tools.starship;
in
{
  options.programs.terminal.tools.starship = with types; {
    enable = mkBoolOpt false "enable starship";
  };

  config = mkIf cfg.enable {
    programs.btop.enable = true;

    programs.lsd = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "$directory"
          "$hostname"
          "$git_branch"
          "$git_status"
          ######
          "$fill"
          ######
          "$battery"
          "$nix_shell"
          "$lua"
          "$python"
          "$bun"
          "$nodejs"
          "$rust"
          "$swift"
          "$zig"
          "$cmd_duration"
          "$line_break"
          ######
          "$character"
        ];
        hostname = {
          ssh_only = false;
          style = "fg:purple";
          format = "[@$hostname ]($style)";
        };
        fill = {
          symbol = " ";
        };
      };
    };
  };
}
