dirname := shell('basename "$1"', justfile_directory())

rebuild:
    nix profile remove '{{dirname}}'
    nix profile install
