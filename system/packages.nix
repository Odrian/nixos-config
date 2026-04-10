{ config, pkgs, ... }:

let
  settings = import ../settings.nix;
  pkgs-unstable = import <nixpkgs-unstable> { config = { allowUnfree = true; }; };
in {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  hardware.graphics.enable32Bit = true; # for Proton
  hardware.steam-hardware.enable = true; # for gamepad

  virtualisation.docker.enable = true;
  users.users.${settings.username}.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    aspellDicts.ru

    obsidian
    telegram-desktop
    # discord
    pkgs-unstable.yandex-music
    throne # vpn
    pinta # image editor
    python3
    zoom-us

    vlc # video player
    unzip wget micro tree
    flameshot

    kdePackages.filelight # disk usage analyzer
    gparted exfatprogs # disk partitioning tool

    sbctl niv # for secure boot

    # thunderbird
    kdePackages.kate
    gnome-system-monitor

#    gnomeExtensions.appindicator
#    gnomeExtensions.tray-icons-reloaded
#    gnomeExtensions.topicons-plus
#    gnomeExtensions.dash-to-panel
  ];
#  services.udev.packages = with pkgs; [
#    gnome-settings-daemon
#  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];
}
