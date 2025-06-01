{ config, pkgs, ... }:

let
  zapret-src = pkgs.fetchFromGitHub {
    owner = "Sergeydigl3";
    repo = "zapret-discord-youtube-linux";
    rev = "59301aaba4f97a24fa416007cb06e00ab6e897a9";
    sha256 = "sha256-MxHBjCw+gQ4IWaJI3KYXmeLFmKNu9PHEtSz8nIK8gPA=";
  };

  configText = ''
    interface=wlp2s0
    auto_update=false
    strategy=general_alt5.bat
  '';

  repoPath = "$HOME/.zapret";
  confEnvPath = "${repoPath}/conf.env";
  scriptPath = "${repoPath}/main_script.sh";
in {
  home.packages = [ pkgs.bash ];

  # update config
  home.activation.zapretConf = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    rm -rf "${repoPath}"
    mkdir -p "${repoPath}"
    cp -r ${zapret-src}/* "${repoPath}"
    chmod -R u+w "${repoPath}"
    echo "${configText}" > ${confEnvPath}
  '';

  home.file."zapret.sh".text = ''
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

  # systemd user unit
  systemd.user.services.zapret = {
    Unit = {
      Description = "Run zapret-discord-youtube-linux";
      After = [ "default.target" ];
    };

    Service = {
      ExecStart = "${pkgs.bash}/bin/bash ${scriptPath} -nointeractive";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
