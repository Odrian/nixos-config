{ ... }:

{
  home.file."rebuild.sh" = {
    text = ''
      sudo nixos-rebuild switch
    '';
    executable = true;
  };

  home.file."clear_all.sh" = {
    text = ''
read -p "Are you sure you want to delete old generation? [yes]: " confirm

if [[ "$confirm" == "yes" ]]; then
  echo "Today generations will not be deleted"
  read -p "Do you want keep only last generation? [absolutely/no]: " confirm2

  if [[ "$confirm2" == "absolutely" ]] then
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
