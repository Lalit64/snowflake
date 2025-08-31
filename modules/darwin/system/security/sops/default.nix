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
  cfg = config.system.security.sops;
in
{
  options.system.security.sops = with types; {
    enable = mkBoolOpt false "enable sops secrets";
    defaultSopsFile = mkOpt lib.types.path null "default sops file";
  };

  config = mkIf cfg.enable {
    sops = {
      inherit (cfg) defaultSopsFile;
      defaultSopsFormat = "yaml";

      age = {
        keyFile = "${config.users.users.${config.user.name}.home}/.config/sops/age/keys.txt";
      };
    };

    sops.secrets = { };
  };
}
