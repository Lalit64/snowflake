{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.system.nix;
in
{
  options.system.nix = with types; {
    enable = mkBoolOpt false "enable nix";
  };

  config = mkIf cfg.enable {
    documentation = {
      doc.enable = false;
      info.enable = false;
      man.enable = true;
    };

    nixpkgs = {
      config.allowUnfree = true;
      config.allowUnfreePredicate = _: true;
    };

    nix.enable = false;

    nix = {
      extraOptions = ''
        # bail early on missing cache hits
        connect-timeout = 10
        keep-going = true
      '';

      checkConfig = true;
      distributedBuilds = true;

      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };
  };
}
