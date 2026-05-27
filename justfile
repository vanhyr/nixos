set quiet

# TODO -> Use nixos-rebuild-ng

hostname := `hostname` # get's the hostname and stores it as a variable

default:
  @just --list

# Local

update:
  sudo nix flake update

check:
  sudo nix flake check

dry-run:
  sudo nixos-rebuild dry-activate --flake .#{{hostname}}

test:
  sudo nixos-rebuild test --flake .#{{hostname}}

switch:
  sudo nixos-rebuild switch --flake .#{{hostname}}

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

@optimize:
  nix-store --optimize

@fix:
  nix-store --repair --verify --check-contents
