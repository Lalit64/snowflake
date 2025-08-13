{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.user;
in
{
  options.user = with types; {
    name = mkOpt str "lalit" "the name to use for the user account.";
    fullname = mkOpt str "Lalit Yalamanchili" "the full name of the user";
    email = mkOpt str "lalit.yalamanchili@gmail.com" "the email of the user";
    extraOptions = mkOpt attrs { } "extra options passed to <option>users.users.<name></option>.";
  };

  config = {
    users.users.${cfg.name} = {
      inherit (cfg) name;
      home = "/Users/${cfg.name}";
    }
    // cfg.extraOptions;

    system.primaryUser = cfg.name;
  };
}
