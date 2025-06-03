{ ... }:

let
  settings = import ../settings.nix;
in
{
  programs.git = {
    enable = true;

    lfs.enable = true;
    delta.enable = true;

    userName = settings.git.userName;
    userEmail = settings.git.userEmail;

    # signing = {
      # signByDefault = true;
      # key = "3C23C7BD99452036";
    # };

    extraConfig = {
      core.editor = "micro";
      init.defaultBranch = "main";
      # pull.rebase = true;
      # push.autoSetupRemote = true;
    };
  };
  
}
