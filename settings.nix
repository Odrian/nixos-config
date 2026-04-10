rec {
  os = "linux"; # CHANHE: macos, linux or windows; only for ifs inside config

  username = ""; # CHANGE: your username
  userDescription = "Adrian";
  hostname = "nixos";
  timeZone = "Europe/Moscow";

  path-to-config = "/home/${username}/nixos-config"; # CHANGE: directory where this file is located

  intelBusId = "PCI:0:2:0";
  nvidiaBusId = "PCI:1:0:0";

  proxy = {
    default = null;
    noProxy = null;
  };

  git = {
    user.name  = null; # CHANGE
    user.email = null; # CHANGE

    core.autocrlf = false;
    core.excludeFiles = "~/.global_gitignore";
    core.editor = "micro";
    core.pager = "delta";
    diff.algorithm = "histogram";
    init.defaultBranch = "main";

    push.default = "current";
    push.autoSetupRemote = true;
    pull.ff = "only"; # fast forward only
    merge.conflictstyle = "zdiff3";

    help.autocorrect = 10; # autorun corrected after 1.0 second
    credential.helper = {
      macos = "osxkeychain";
      linux = "libsecret";
      win = "wincred";
    }.${os};

    transfer.fsckobjects = true;
    fetch.fsckobjects = true;
    receive.fsckObjects = true;

    log.date = "iso";
  };
}
