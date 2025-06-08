{ pkgs, ... }:

let
  # Импорт flake вручную
  zen-browser-flake = builtins.getFlake "github:Gurjaka/zen-browser-nix";
  zen-browser = zen-browser-flake.packages.${pkgs.system}.default;
in
{
  home.packages = [
    zen-browser
  ];

  home.file.".config/autostart/zen.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Zen browser
    Exec=zen
  '';
}
