{ ... }:

let
  settings = import ../settings.nix;
in
{
  home.file."gpu.sh" = {
    text = ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '';
    executable = true;
  };
  home.file."no_proxy.sh" = {
    text = ''
      unset NIX_REMOTE all_proxy http_proxy https_proxy ftp_proxy rsync_proxy
      "$@"
    '';
    executable = true;
  };
  home.file."custom_rebuild.sh" = {
    text = ''
      from=$(~/no_proxy.sh nix-build '<nixpkgs/nixos>' -I nixos-config=/etc/nixos/configuration.nix --no-out-link -A system)
      echo "$from/bin/switch-to-configuration"
    '';
    executable = true;
  };
  home.file."rebuild.sh" = {
    text = ''
      sudo nixos-rebuild switch --flake ${settings.path-to-config}#nixos
    '';
    executable = true;
  };

  home.file."clear_all.sh" = {
    text = ''
read -p "Are you sure you want to delete old generation? [yes]: " confirm

if [[ "$confirm" == "yes" ]]; then
  echo "Today generations will not be deleted"
  read -p "Do you want keep only last generation? [yes/no]: " confirm2

  if [[ "$confirm2" == "yes" ]] then
    echo "KEEP ONLY THIS GENERATION"
    sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system
    sudo nix-collect-garbage
  else
    echo "KEEP TODAY GENERATIONS"
    sudo nix-env --delete-generations 1d --profile /nix/var/nix/profiles/system
    sudo nix-collect-garbage
  fi
fi
    '';
    executable = true;
  };
}
