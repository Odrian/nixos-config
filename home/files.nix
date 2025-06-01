{ ... }:

{
   home.file = {
    "rebuild.sh".text = ''
      sudo nixos-rebuild switch
    '';

    "clear_all.sh".text = ''
read -p "Are you sure you want to delete old generation? [yes]: " confirm

if [[ "$confirm" == "yes" ]]; then
  echo "Last 5 generations will not be deleted"
  read -p "Do uou want keep only last generation? [absolutely]: " confirm2

  if [[ "$confirm2" == "absolutely" ]] then
    echo "KEEP ONLY THIS GENERATION"
    sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system
    sudo nix-collect-garbage
  else
    echo "KEEP LAST 5 GENERATIONS"
    sudo nix-env --delete-generations +5 --profile /nix/var/nix/profiles/system
    sudo nix-collect-garbage
  fi
fi
    '';

    "zapret.sh".text = ''
set -e  # Остановить выполнение при ошибке

# Путь до env-файла
REPO_PATH="$HOME/workspace/zapret-discord-youtube-linux"
CONFIG_FILE="$REPO_PATH/conf.env"
SCRIPT_FILE="$REPO_PATH/main_script.sh"

# Записываем содержимое в конфигурационный файл
cat > "$CONFIG_FILE" <<EOF
interface=wlp2s0
auto_update=false
strategy=general_alt.bat
EOF

echo "Конфигурация записана в $CONFIG_FILE"

# Запускаем основной скрипт
bash "$SCRIPT_FILE" -nointeractive
    '';
  };
}
