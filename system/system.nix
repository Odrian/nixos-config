{ ... }:

let
  settings = import ../settings.nix;
in
{
  boot.supportedFilesystems = [ "ntfs" ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users."${settings.username}" = { ... }: {
    # info for home manager
    home.username = "${settings.username}";
    home.homeDirectory = "/home/${settings.username}";

    home.stateVersion = "25.05"; # don't change

    programs.home-manager.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.hardwareClockInLocalTime = true; # fix time in Windows

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Read before changing https://search.nixos.org/options?query=system.stateVersion
  system.stateVersion = "25.05"; # Do not change this value
}
