{
  config,
  lib,
  ...
}:
let
  cfg = config.user;
in
{
  imports = [ (lib.snowfall.fs.get-file "modules/shared/user/default.nix") ];

  config = {
    users.users.${cfg.name} = {
      inherit (cfg) name;
      home = "/Users/${cfg.name}";
    }
    // cfg.extraOptions;

    system.primaryUser = cfg.name;
  };
}
