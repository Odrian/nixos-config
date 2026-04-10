{ ... }:

let
  settings = import ../settings.nix;
in
{
  programs.git = {
    enable = true;

    lfs.enable = true;

    settings = settings.git;
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
