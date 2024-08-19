{ pkgs, ... }:

let sets = with pkgs; {
  core = [
    git
    wget
  ];

  editors = [
    nano
  ];

  utils = [
    tldr
    gh
  ];
};

in {
  environment.systemPackages = builtins.concatLists (builtins.attrValues sets);
}
