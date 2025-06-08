{ config, pkgs, ... }:

# let
#   settings = import ../settings.nix;

#   zapret-src = pkgs.fetchFromGitHub {
#     owner = "Sergeydigl3";
#     repo = "zapret-discord-youtube-linux";
#     rev = "59301aaba4f97a24fa416007cb06e00ab6e897a9";
#     sha256 = "sha256-MxHBjCw+gQ4IWaJI3KYXmeLFmKNu9PHEtSz8nIK8gPA=";
#   };

#   configText = ''
#     interface=${settings.zapret.wifi}
#     auto_update=false
#     strategy=${settings.zapret.strategy}
#   '';

#   repoPath = "$HOME/.zapret";
#   confEnvPath = "${repoPath}/conf.env";
#   scriptPath = "${repoPath}/main_script.sh";
# in
{
  home.packages = with pkgs; [ bash nftables ];

  # update config
  # home.activation.zapretConf = config.lib.dag.entryAfter [ "writeBoundary" ] ''
  #   rm -rf "${repoPath}"
  #   mkdir -p "${repoPath}"
  #   cp -r ${zapret-src}/* "${repoPath}"
  #   chmod -R u+w "${repoPath}"
  #   echo "${configText}" > ${confEnvPath}
  # '';

  home.file."zapret.sh".text = ''
GIT_LINK="https://github.com/Sergeydigl3/zapret-discord-youtube-linux.git"
TARGET_DIR="$HOME/.zapret"
BASH_SCRIPT="$TARGET_DIR/main_script.sh"

HARD_MODE=false
if [[ "$1" == "--hard" ]]; then
  HARD_MODE=true
fi

# Клонирование репозитория
if [[ -d "$TARGET_DIR" ]]; then
  if $HARD_MODE; then
    echo "Клонирование репозитория в $TARGET_DIR..."
    rm -rf "$TARGET_DIR"
    git clone "$GIT_LINK" "$TARGET_DIR"
  fi
else
  echo "Клонирование репозитория в $TARGET_DIR..."
  git clone "$GIT_LINK" "$TARGET_DIR"
fi

bash $BASH_SCRIPT
  '';
}
