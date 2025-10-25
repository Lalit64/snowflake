# just is a command runner, justfile is very similar to Makefile, but simpler.

# TODO update hostname here!
hostname := `hostname`

# list all just commands
[private]
default: 
  @just --list

############################################################################
#
#  Darwin related commands
#
############################################################################

[group('system')]
switch:
  nh darwin switch --flake .

[group('system')]
build:
  nh darwin build .

[group('system')]
build-debug:
  nh darwin build --verbose

############################################################################
#
#  nix related commands
#
############################################################################

# Update all the flake inputs
[group('nix')]
up:
  nix flake update

# Update specific input
# Usage: just upp nixpkgs
[group('nix')]
upp input:
  nix flake update {{input}}

# List all generations of the system profile
[group('nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Open a nix shell with the flake
[group('nix')]
repl:
  nix repl -f flake:nixpkgs

# remove all generations older than 7 days
[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# garbage collect all unused nix store entries
[group('nix')]
gc:
  # garbage collect all unused nix store entries(system-wide)
  sudo nix-collect-garbage --delete-older-than 7d
  # garbage collect all unused nix store entries(for the user - home-manager)
  # https://github.com/NixOS/nix/issues/8508
  nix-collect-garbage --delete-older-than 7d

# format the nix files in this repo
[group('nix')]
fmt:
  nix fmt

# Show all the auto gc roots in the nix store
[group('nix')]
gcroot:
  ls -al /nix/var/nix/gcroots/auto/

############################################################################
#
#  VCS related commands
#
############################################################################

[group('jj')]
add:
  jj bookmark s main

[group('jj')]
commit:
  jj describe

[group('jj')]
push:
  jj git push
