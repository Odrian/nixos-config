My config for nixos

# Setup
run
```
bash setup.sh
```
it will create /etc/nixos/configuration.nix which import "./hardware-configuration.nix" and "${CONFIG_DIR}/configuration.nix"

you probably want to change git username and email in /user/home/git.nix

# First use
```
sudo nix-channel --remove nixpkgs
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

sudo nixos-rebuild switch
```
# After updating config
```
sudo nixos-rebuild switch
```
# TODO

* add to autostart: nekoray, telegram, zen, discord
* fix zapret.nix
