
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

