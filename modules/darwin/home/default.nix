{
  options,
  config,
  lib,
  inputs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
{
  imports = with inputs; [
    home-manager.darwinModules.home-manager
  ];

  options.home = with types; {
    file = mkOpt attrs { } "a set of files to be managed by home-manager's <option>home.file</option>.";
    configFile =
      mkOpt attrs { }
        "a set of files to be managed by home-manager's <option>xdg.configFile</option>.";
    programs = mkOpt attrs { } "programs to be managed by home-manager.";
    extraOptions = mkOpt attrs { } "options to pass directly to home-manager.";
  };

  config = {
    home.extraOptions = {
      home.stateVersion = "24.11";
      home.file = mkAliasDefinitions options.home.file;
      imports = with inputs; [ ];
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.home.configFile;
      programs = mkAliasDefinitions options.home.programs;
    };

    home-manager = {
      useUserPackages = true;

      users.${config.user.name} = mkAliasDefinitions options.home.extraOptions;
    };
  };
}
