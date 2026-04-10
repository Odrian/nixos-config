{ ... }:

let
  settings = import ../settings.nix;
in
{
  boot.supportedFilesystems = [ "ntfs" ];

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16*1024; # 16 GB
  }];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.hardwareClockInLocalTime = true; # fix time in Windows

  boot.loader = {
    systemd-boot.enable = false; # to use simpler boot enable this and disable grub
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      default = 0; # nixos by default
      theme = "${settings.path-to-config}/grub-theme";
      splashImage = "${settings.path-to-config}/grub-theme/background.png";
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Read before changing https://search.nixos.org/options?query=system.stateVersion
  system.stateVersion = "25.05"; # Do not change this value
}
