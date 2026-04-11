{ ... }:

let
  settings = import ../settings.nix;
  username = settings.username;
in
{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.05"; # don't change

  programs.home-manager.enable = true;
}
