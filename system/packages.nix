{ pkgs, ... }:

let sets = with pkgs; {
  core = [
    git
    bash
  ];

  editors = [
    nano
  ];

  browsers = [
    firefox
  ];

  utils = [
    wget
    tldr
    gh
    foot
  ];
};

in {
  environment.systemPackages = builtins.concatLists (builtins.attrValues sets);
}
