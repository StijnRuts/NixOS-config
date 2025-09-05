default: run

generate:
	nix run .\#genflake flake.nix
build:
	# nixos-rebuild build --show-trace --flake .
	nh os build .
test:
	# sudo nixos-rebuild test --show-trace --flake .
	nh os test .
run:
	# sudo nixos-rebuild switch --show-trace --flake .
	nh os switch .
update:
	nix flake update
format:
	treefmt .
lint:
	statix check . && deadnix
clean:
	sudo nix-collect-garbage --delete-older-than 30d
