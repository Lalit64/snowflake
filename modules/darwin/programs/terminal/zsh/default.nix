{
  options,
  config,
  lib,
  namespace,
  pkgs,
  inputs,
  system,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.zsh;
in
{
  options.programs.terminal.zsh = with types; {
    enable = mkBoolOpt false "enable zsh";
  };

  config = mkIf cfg.enable {
    programs.terminal.git = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      zoxide
      statix
    ];

    home.programs.zsh = {
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
        ns = "${pkgs.nh}/bin/nh darwin switch";
        nhash = ''nix hash to-sri --type sha256 $(nix-prefetch-url "$1")'';

        cd = "z";
        ls = "${pkgs.eza}/bin/eza --icons";
        tree = "${pkgs.eza}/bin/eza --icons --tree";
        ff = "${pkgs.fastfetch}/bin/fastfetch";
        lg = "${pkgs.lazygit}/bin/lazygit";
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
