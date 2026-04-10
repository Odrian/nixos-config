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

  imports = [
    ./files.nix
    ./git.nix
    ./helix.nix
    ./zen.nix

    ./rust.nix
    ./cpp.nix
  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      # bash prefix
      export PS1='\[\e[32m\]┌──(\[\e[94;1m\]\u\[\e[94m\]@\[\e[94m\]\h\[\e[0;32m\])-[\[\e[38;5;46;1m\]\w\[\e[0;32m\]] [\[\e[32m\]$?\[\e[32m\]]\n\[\e[32m\]╰─\[\e[94;1m\]\$\[\e[0m\] '
      # highlight in ls .nix with purple
      export LS_COLORS="$LS_COLORS:*.nix=01;35"
    '';
  };
}
