
# Получаем абсолютный путь к директории, где находится setup.sh
CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Пишем конфигурацию с подстановкой пути
sudo tee /etc/nixos/configuration.nix > /dev/null <<EOF
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ${CONFIG_DIR}/configuration.nix
  ];
}
EOF

echo "/etc/nixos/configuration.nix создан с импортом из ${CONFIG_DIR}/configuration.nix"
