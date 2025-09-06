default: run

# Generate the flake imputs based on flake.template.nix
generate:
	nix run .\#genflake flake.nix

# Only build the configuration, but do not switch to it
build:
	# nixos-rebuild build --show-trace --flake .
	nh os build .

# Build the configuration and switch to it, but do not add it to the boot manager
test:
	# sudo nixos-rebuild test --show-trace --flake .
	nh os test .

# Build the configuration, switch to it, and add it to the boot manager
run:
	# sudo nixos-rebuild switch --show-trace --flake .
	nh os switch .

# Build only the Home Manager configuration, and switch to it
home:
	# HOSTNAME=$$(hostname) home-manager switch --show-trace -b hmbackup --flake ./partial/home --impure
	HOSTNAME=$$(hostname) nh home switch -b hmbackup ./partial/home -- --impure

# Build only the vim configuration, and run it
vim:
	nix run ./partial/vim

# Update the flake.lock file
update:
	nix flake update

# Format all .nix files
format:
	treefmt .

# Lint all .nix files
lint:
	statix check . && deadnix

# Clean the nix store
clean:
	sudo nix-collect-garbage --delete-older-than 30d
