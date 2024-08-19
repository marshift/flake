{ pkgs, ... }:

let sets = with pkgs; {
  core = [
    git
    bash
  ];

  editors = [
    nano
  ];

  utils = [
    wget
    tldr
    gh
  ];
};

in {
  environment.systemPackages = builtins.concatLists (builtins.attrValues sets);
}
