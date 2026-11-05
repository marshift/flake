{
  inputs,
  pkgs,
  ...
}:
{
  programs.vscode.profiles.default = {
    userSettings = {
      "workbench.colorTheme" = "Monokai Pro (Filter Spectrum)";
      "workbench.iconTheme" = "Monokai Pro (Filter Spectrum) Icons";
      "editor.fontFamily" = "Fira Code";
      "editor.fontSize" = 16;
    };

    extensions =
      with inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace; [
        monokai.theme-monokai-pro-vscode
      ];
  };
}
