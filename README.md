My config for nixos

# Setup

setup channels
```
sudo nix-channel --remove nixpkgs
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

```
than run
```
bash setup.sh
```
it will create /etc/nixos/configuration.nix which import "./hardware-configuration.nix" and "${CONFIG_DIR}/configuration.nix"

you SHOULD change git username and email in /user/home/git.nix

than rebuild system
```
bash ./rebuild.sh
```

# Using

Shortcut for nixos-rebuild switch
```
bash ./rebuild.sh
```
Delete old generations (keep last 5 or only last)
```
bash ./clear_all.sh
```
# TODO

* add to autostart: nekoray, telegram, zen, discord
* fix zapret.nix
