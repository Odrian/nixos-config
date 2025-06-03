{ config, pkgs, ... }:

let
  settings = import ../settings.nix;

  zapret-src = pkgs.fetchFromGitHub {
    owner = "Sergeydigl3";
    repo = "zapret-discord-youtube-linux";
    rev = "59301aaba4f97a24fa416007cb06e00ab6e897a9";
    sha256 = "sha256-MxHBjCw+gQ4IWaJI3KYXmeLFmKNu9PHEtSz8nIK8gPA=";
  };

  configText = ''
    interface=${settings.zapret.wifi}
    auto_update=false
    strategy=${settings.zapret.strategy}
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
    bash ${scriptPath} -nointeractive
  '';

  # systemd user unit
  systemd.user.services.zapret = {
    Unit = {
      Description = "Run zapret-discord-youtube-linux";
      After = [ "default.target" ];
    };

    Service = {
      ExecStart = "sudo ${pkgs.bash}/bin/bash ~/zapret.sh";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
