# Получаем абсолютный путь к директории, где находится setup.sh
CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


echo "... updating channels"
sudo nix-channel --add https://nixos.org/channels/nixos-25.11 nixos
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
sudo nix-channel --update
echo "channels successfully updated"


# Пишем конфигурацию с подстановкой пути
sudo tee /etc/nixos/configuration.nix > /dev/null <<EOF
{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ${CONFIG_DIR}/configuration.nix
  ];
}
EOF
echo "/etc/nixos/configuration.nix создан с импортом из ${CONFIG_DIR}/configuration.nix"


echo "installing home-manager"
nix-shell '<home-manager>' -A install
# TODO: add somewhere . /etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh
tee "$HOME/.config/home-manager/home.nix" > /dev/null <<EOF
{
  imports = [
    "${CONFIG_DIR}/home/default.nix"
  ];
}
EOF
echo "$HOME/.config/home-manager/home.nix создан с импортом из ${CONFIG_DIR}/home/default.nix"
