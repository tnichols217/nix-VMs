#!/usr/bin/env bash

upsearch () {
  local slashes=${PWD//[^\/]/}
  local directory=$(pwd)
  for (( n=${#slashes}; n>0; --n ))
  do
    test -e "$directory/$1" && cd $directory 
    directory="$directory/.."
  done
}

upsearch flake.nix

nix build .\#nixosConfigurations.VM.config.system.build.vm
export TMPDIR=$(realpath ./tmp)
./result/bin/run-VM-vm
rm VM.qcow2