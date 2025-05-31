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
