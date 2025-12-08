{ ... }:

let
  settings = import ../settings.nix;
in
{
  programs.git = {
    enable = true;

    lfs.enable = true;

    settings = {
      user.name = settings.git.userName;
      user.email = settings.git.userEmail;

    # signing = {
      # signByDefault = true;
      # key = "3C23C7BD99452036";
    # };

      core.editor = "micro";
      init.defaultBranch = "main";
      # pull.rebase = true;
      # push.autoSetupRemote = true;
      credential.helper = "store"; # NOT ENCRYPTED cache username and password
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
