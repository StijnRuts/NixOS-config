default: run

# Generate the flake imputs based on flake.template.nix
genflake:
	nix run .\#genflake flake.nix

# Only build the configuration, but do not switch to it
build: genflake
	# nixos-rebuild build --show-trace --flake .
	nh os build .

# Build the configuration and switch to it, but do not add it to the boot manager
test: genflake
	# sudo nixos-rebuild test --show-trace --flake .
	nh os test .

# Build the configuration, switch to it, and add it to the boot manager
run: genflake
	# sudo nixos-rebuild switch --show-trace --flake .
	nh os switch .

# Update the flake.lock file
update: genflake
	nix flake update

# Format all .nix files
format:
	treefmt . --excludes apps/vim/snippets/**/*.nix

# Lint all .nix files
lint:
	statix check --ignore apps/vim/snippets/**/*.nix -- .
	deadnix --exclude apps/vim/snippets/**/*.nix

# Clean the nix store
clean:
	sudo nix-collect-garbage --delete-older-than 30d
