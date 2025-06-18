My config for nixos

## For new Nixos users

Setup password, if didn't ```passwd```

Setup channels
````
sudo nix-channel --remove nixpkgs
sudo nix-channel --add https://nixos.org/channels/nixos-25.05 nixos
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
sudo nix-channel --update
````

# Setup

Clone repository
````
git clone https://github.com/Odrian/nixos-config.git
cd nixos-config
````

### Configure

Find GPU busId ````nix shell nixpkgs#pciutils -c lspci -d ::03xx````
````
00:02.0 VGA compatible controller: Intel Corporation TigerLake-H GT1 [UHD Graphics] (rev 01)
01:00.0 3D controller: NVIDIA Corporation GA107M [GeForce RTX 3050 Ti Mobile] (rev a1)
````
Remove leading zeros and convert from hexadecimal to decimal.\
For me they are: intelBusId = "PCI:0:2:0", nvidiaBusId = "PCI:1:0:0"

Edit username, GPU busId, git username and email
````
nix-shell -p micro
micro settings.nix
````

### Build

Run ````bash setup.sh````, it will create /etc/nixos/configuration.nix which import "./hardware-configuration.nix" and "${CONFIG_DIR}/configuration.nix"

For first rebuild use
````
sudo nixos-rebuild switch --option experimental-features "nix-command flakes"
````

# Shortcuts

Shortcut for nixos-rebuild switch
````
~/rebuild.sh
````
Delete old generations (keep today generations or only last)
````
~/clear_all.sh
````

# TODO

* add to autostart: nekoray, telegram, discord
* support single GPU
* make flag in settings.nix for first run
* move all programs to home/*.nix
