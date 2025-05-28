{ ... }:

{
  programs.git = {
    enable = true;

    lfs.enable = true;
    delta.enable = true;

    userName = "Odrian";
    userEmail = "adrian46tver@bk.ru";

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
