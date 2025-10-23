let
  lalit = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBL6IaEV/vrdPUQWCy20UbStYyq3lVcRvXP8YaIskhtD lalit.yalamanchili@gmail.com";
in
{
  "tailscale-authkey.age".publicKeys = [
    lalit
  ];
}
