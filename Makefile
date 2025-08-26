default: run

build:
	nixos-rebuild build --show-trace --log-format internal-json -v --flake . |& nom --json
test:
	sudo sh -c 'nixos-rebuild test --show-trace --log-format internal-json -v --flake . |& nom --json'
run:
	sudo sh -c 'nixos-rebuild switch --show-trace --log-format internal-json -v --flake . |& nom --json'
update:
	sudo nix flake update
format:
	treefmt .
clean:
	sudo nix-collect-garbage --delete-older-than 30d
