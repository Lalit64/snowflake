{
  config,
  lib,
  options,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
{
  options.${namespace}.home = with types; {
    file = mkOpt attrs { } "a set of files to be managed by home-manager's <option>home.file</option>.";
    configFile =
      mkOpt attrs { }
        "a set of files to be managed by home-manager's <option>xdg.configFile</option>.";
    extraOptions = mkOpt lib.types.attrs { } "options to pass directly to home-manager.";
    homeConfig = mkOpt lib.types.attrs { } "final config for home-manager.";
  };

  config = {
    ${namespace}.home.extraOptions = {
      home.file = lib.mkAliasDefinitions options.${namespace}.home.file;
      xdg.enable = true;
      xdg.configFile = lib.mkAliasDefinitions options.${namespace}.home.configFile;
    };

    home-manager.users.${config.user.name} =
      lib.mkAliasDefinitions
        options.${namespace}.home.extraOptions;

    home-manager = {
      # enables backing up existing files instead of erroring if conflicts exist
      backupFileExtension = "hm.old";

      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
