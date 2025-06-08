{ config, lib, ... }:

let
  settings = import ../settings.nix;
in
{
  # specialisation = {
  #   on-the-go.configuration = {
  #     system.nixos.tags = [ "on-the-go" ];
  #     hardware.nvidia = {
  #       prime.offload.enable = lib.mkForce true;
  #       prime.offload.enableOffloadCmd = lib.mkForce true;
  #       prime.sync.enable = lib.mkForce false;
  #     };
  #   };
  # };

  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [
    "nvidia"
    "modesetting"
  ];

  hardware.nvidia = {
    open = false;

    prime = {
      intelBusId = settings.intelBusId;
      nvidiaBusId = settings.nvideaBusId;

      # offload = { # option A
      #   enable = true;
      #   enableOffloadCmd = true;
      # };
      sync.enable = true; # option B
      # reverseSync.enable = true; # option C
    };

    powerManagement.enable = true;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
