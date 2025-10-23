# ❄️Snowflake

## Install

- Install Nix, using determinate systems' installer:

  ```sh-session
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate
  ```

- First time run:

  ```bash
  git clone git@github.com:Lalit64/snowflake.git ~/.config/snowflake && cd ~/.config/snowflake

  # first time

  sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .

  # afterwards

  ns
  ```
