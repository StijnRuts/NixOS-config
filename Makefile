default: run

build:
	nh os build . # nixos-rebuild build --show-trace --flake .
test:
	nh os test . # sudo nixos-rebuild test --show-trace --flake .
run:
	nh os switch . # sudo nixos-rebuild switch --show-trace --flake .
update:
	nix flake update
format:
	treefmt .
lint:
	statix check .
clean:
	sudo nix-collect-garbage --delete-older-than 30d

