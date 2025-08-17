default: run

build:
	nixos-rebuild build --show-trace --flake .
test:
	sudo nixos-rebuild test --show-trace --flake .
run:
	sudo nixos-rebuild switch --show-trace --flake .
update:
	sudo nix flake update
format:
	treefmt .
clean:
	sudo nix-collect-garbage --delete-older-than 30d
