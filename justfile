set quiet

hostname := `hostname` # get's the hostname and stores it as a variable

default:
  @just --list

# Local

update:
  nix flake update

check:
  nix flake check

dry-run:
  #sudo nixos-rebuild dry-activate --flake .#{{hostname}}
  doas nixos-rebuild dry-activate --flake .#{{hostname}}

test:
  doas nixos-rebuild test --flake .#{{hostname}}
  #sudo nixos-rebuild test --flake .#{{hostname}}

switch:
  doas nixos-rebuild switch --flake .#{{hostname}}
  #sudo nixos-rebuild switch --flake .#{{hostname}}

switch-nh:
  nh os switch . -H {{hostname}}

#switch-upgrade:
#  sudo nixos-rebuild switch --upgrade --flake .#{{hostname}}

fmt:
  nix fmt

check-clean:
  if [ -n "$(git status --porcelain)" ]; then echo -e "\e[31merror\e[0m: git tree is dirty. Refusing to copy configuration." >&2; exit 1; fi

# Remote

dry-run-remote host:
  nixos-rebuild dry-activate --flake .#{{host}} --target-host {{host}} --build-host {{host}} --no-reexec --sudo --ask-sudo-password

deploy host:
  nixos-rebuild switch --flake .#{{host}} --target-host {{host}} --build-host {{host}} --no-reexec --sudo --ask-sudo-password

deploy-upgrade-remote host:
  nixos-rebuild switch --upgrade --flake .#{{host}} --target-host {{host}} --build-host {{host}} --no-reexec --sudo --ask-sudo-password

copy host:
  rsync -ax --delete --rsync-path="sudo rsync" ./ {{host}}:/etc/nixos/

# Maintenance

@clean:
  nix-collect-garbage -d

@clean-nh:
  nh clean all

@optimize:
  nix-store --optimize

@fix:
  nix-store --repair --verify --check-contents
