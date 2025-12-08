{ ... }:

let
  settings = import ../settings.nix;
  username = settings.username;
in
{
  boot.supportedFilesystems = [ "ntfs" ];

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16*1024; # 16 GB
  }];

  fileSystems."/D" = {
    device = "/dev/disk/by-uuid/8760-5E23";
    fsType = "exfat";
    options = [ "rw" "uid=1000" "gid=100" "umask=0000" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users."${username}" = { ... }: {
    # info for home manager
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

    home.stateVersion = "25.05"; # don't change

    programs.home-manager.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.hardwareClockInLocalTime = true; # fix time in Windows

  boot.loader.systemd-boot = {
    # to use simpler boot enable this and comment disable boot.loader.grub.enable
    enable = false;
  };
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
    default = 2; # windows by default
    theme = "${settings.path-to-config}/grub-theme";
    splashImage = "${settings.path-to-config}/grub-theme/background.png"; # 1 more second of image
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Read before changing https://search.nixos.org/options?query=system.stateVersion
  system.stateVersion = "25.05"; # Do not change this value
}
