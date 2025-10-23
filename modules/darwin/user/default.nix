{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.user;
in
{
  imports = [ (lib.snowfall.fs.get-file "modules/shared/user/default.nix") ];

  config = {
    users.knownUsers = [ "${cfg.name}" ];

    users.users.${cfg.name} = {
      inherit (cfg) name;
      home = "/Users/${cfg.name}";
      uid = 501;
      shell = pkgs.zsh;
    }
    // cfg.extraOptions;

    system.primaryUser = cfg.name;
  };
}
