My config for nixos

# Setup

setup password ```passwd```

setup channels
````
sudo nix-channel --remove nixpkgs
sudo nix-channel --add https://nixos.org/channels/nixos-25.05 nixos
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
sudo nix-channel --update
````

use ````ifconfig```` to find wifi module name for zapret

download and configure config
````
git clone https://github.com/Odrian/nixos-config.git
cd nixos-config
nix-shell -p micro
micro settings.nix
````
than run ````bash setup.sh````, it will create /etc/nixos/configuration.nix which import "./hardware-configuration.nix" and "${CONFIG_DIR}/configuration.nix"

for russia: before first build run ````micro ./system/packages.nix```` and add "#" before "discord"

than for first rebuild use
````
sudo nixos-rebuild switch --option experimental-features "nix-command flakes"
````

later use ````bash ./rebuild.sh````

# Using

Shortcut for nixos-rebuild switch
````
bash ./rebuild.sh
````
Delete old generations (keep last 5 or only last)
````
bash ./clear_all.sh
````

# TODO

* add to autostart: nekoray, telegram, discord
