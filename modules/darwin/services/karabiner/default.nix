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
  cfg = config.services.karabiner;

  tvApps = pkgs.writeShellScriptBin "tvApps" ''
    ls /Applications/ /Applications/Utilities/ /System/Applications/ /System/Applications/Utilities/ /Applications/Nix\ Apps/ | \
      grep '\.app$' | \
      sed 's/\.app$//g' | \
      /etc/profiles/per-user/lalit/bin/tv | \
      xargs -I {} open -n -a "{}.app"
  '';

  nixTv = pkgs.writeShellScriptBin "nixTv" ''
    ${pkgs.television}/bin/tv nix-search-tv
  '';
in
{
  options.services.karabiner = with types; {
    enable = mkBoolOpt false "enable karabiner-elements";
  };

  config = mkIf cfg.enable {
    ${namespace}.home.file."/Users/${config.user.name}/.config/karabiner/karabiner.json".text = ''
      {
        "global": {
          "ask_for_confirmation_before_quitting": true,
          "check_for_updates_on_startup": true,
          "show_in_menu_bar": true,
          "show_profile_name_in_menu_bar": false,
          "unsafe_ui": false
        },
        "profiles": [
          {
            "name": "Default",
            "virtual_hid_keyboard": {
              "keyboard_type_v2": "ansi"
            },
            "complex_modifications": {
              "rules": [
                {
                  "description": "Launch/show Nix Search if it is not in foreground",
                  "manipulators": [
                    {
                      "type": "basic",
                      "from": {
                        "key_code": "return_or_enter",
                        "modifiers": {
                          "mandatory": [
                            "left_command"
                          ]
                        }
                      },
                      "to": [
                        {
                          "shell_command": "/opt/homebrew/bin/wezterm start --class org.wezfurlong.wezterm.tvApps --always-new-process -- ${pkgs.zsh}/bin/zsh -c ${nixTv}/bin/nixTv"
                        }
                      ],
                      "conditions": [
                        {
                          "type": "frontmost_application_unless",
                          "bundle_identifiers": [
                            "^org\\.wezfurlong\\.wezterm\\.tvApps$"
                          ]
                        }
                      ]
                    }
                  ]
                },
                {
                  "description": "Minimize Nix Search if it is in foreground",
                  "manipulators": [
                    {
                      "type": "basic",
                      "from": {
                        "key_code": "return_or_enter",
                        "modifiers": {
                          "mandatory": [
                            "left_command"
                          ]
                        }
                      },
                      "to": [
                        {
                          "shell_command": "killall " 
                        }
                      ],
                      "conditions": [
                        {
                          "type": "frontmost_application_if",
                          "bundle_identifiers": [
                            "^org\\.wezfurlong\\.wezterm\\.fzfApps$"
                          ]
                        }
                      ]
                    }
                  ]
                },
                {
                  "description": "Mods",
                  "manipulators": [
                    {
                      "description": "Hyper Key",
                      "type": "basic",
                      "from": {
                        "key_code": "caps_lock",
                        "modifiers": {
                          "optional": [
                            "any"
                          ]
                        }
                      },
                      "to": [
                        {
                          "key_code": "left_shift",
                          "modifiers": [
                            "command",
                            "left_control"
                          ]
                        }
                      ],
                      "to_if_alone": [
                        {
                          "key_code": "escape",
                          "modifiers": [
                            "any"
                          ]
                        }
                      ]
                    },
                    {
                      "description": "pmset sleepnow",
                      "type": "basic",
                      "from": {
                        "simultaneous": [
                          {
                            "key_code": "s"
                          }
                        ],
                        "simultaneous_options": {
                          "key_down_order": "strict",
                          "key_up_order": "strict_inverse",
                          "to_after_key_up": [
                            {
                              "set_variable": {
                                "name": "launcher_mode",
                                "value": 0
                              }
                            }
                          ]
                        },
                        "modifiers": {
                          "mandatory": [
                            "left_control",
                            "command",
                            "left_shift"
                          ],
                          "optional": [
                            "any"
                          ]
                        }
                      },
                      "to": [
                        {
                          "set_variable": {
                            "name": "launcher_mode",
                            "value": 1
                          }
                        },
                        {
                          "shell_command": "pmset sleepnow"
                        }
                      ],
                      "parameters": {
                        "basic.simultaneous_threshold_milliseconds": 500
                      }
                    }
                  ]
                }
              ]
            }
          }
        ]
      }
    '';
  };
}
