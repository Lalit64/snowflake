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
  cfg = config.programs.terminal.mise-en-place;
in
{
  options.programs.terminal.mise-en-place = with types; {
    enable = mkBoolOpt false "Enable mise-en-place";
  };

  config = mkIf cfg.enable {
    home.programs.mise = {
      enable = true;
      enableZshIntegration = true;
      globalConfig = {
        tools = {
          node = "latest";
          python = [
            "3.10"
            "3.11"
          ];
          ruby = "latest";
          rust = "latest";
          rust-analyzer = "latest";
          go = "latest";
        };
        settings = {
          idiomatic_version_file_enable_tools = [ ];
        };
      };
    };
  };
}
