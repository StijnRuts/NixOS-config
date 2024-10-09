default: run

build:
	nixos-rebuild build --show-trace --flake .
test:
	sudo nixos-rebuild test --flake .
run:
	sudo nixos-rebuild switch --flake .
update:
	sudo nix flake update
clean:
	sudo nix-collect-garbage --delete-older-than 30d

