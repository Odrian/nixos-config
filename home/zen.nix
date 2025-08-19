{ pkgs, ... }:

let
  # Импорт flake вручную
  zen-browser-flake = builtins.getFlake "github:0xc000022070/zen-browser-flake";
  zen-browser = zen-browser-flake.packages.${pkgs.system}.default;
in
{
  home.packages = [
    zen-browser
  ];

  # home.file.".config/autostart/zen.desktop".text = ''
  #   [Desktop Entry]
  #   Type=Application
  #   Name=Zen browser
  #   Exec=zen
  # '';
}
