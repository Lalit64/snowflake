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
  cfg = config.programs.terminal.shell.zsh;
in
{
  options.programs.terminal.shell.zsh = with types; {
    enable = mkBoolOpt false "enable zsh";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zoxide
      statix
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        ignoreDups = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        save = 1000000;
        size = 1000000;
      };

      shellAliases = {
        cd = "z";
        ls = "${pkgs.lsd}/bin/lsd";
        tree = "${pkgs.lsd}/bin/lsd --tree";
        ff = "${pkgs.fastfetch}/bin/fastfetch";
      };

      initContent = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        export PNPM_HOME="/"
        export EDITOR=/run/current-system/sw/bin/nvim

        # fix rust liconv stuff
        export PATH="/opt/homebrew/opt/libiconv/bin:$PATH"
        export LDFLAGS="-L/opt/homebrew/opt/libiconv/lib"
        export CPPFLAGS="-I/opt/homebrew/opt/libiconv/include"
        export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/lib:$(brew --prefix)/opt/libiconv/lib

        eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
        eval "$(${pkgs.mise}/bin/mise activate zsh)"
        source "${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh"
      '';
    };
  };
}
