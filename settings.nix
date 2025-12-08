rec {
  username = ""; # CHANGE: your username
  userDescription = "Adrian";
  hostname = "nixos";

  path-to-config = "/home/${username}/nixos-config"; # CHANGE: directory where this file is located

  intelBusId = "PCI:0:2:0";
  nvidiaBusId = "PCI:1:0:0";

  zapret = {
    wifi = "wlo1";
    strategy = "general_alt5.bat";
  };

  git = {
    userName  = ""; # CHANGE
    userEmail = ""; # CHANGE
  };
}
