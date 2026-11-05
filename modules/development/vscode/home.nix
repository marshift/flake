{
  inputs,
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isDarwin system;
  inherit (lib.meta) getExe getExe';
in
mkIf osConfig.swamp.development.vscode.enable {
  programs.vscode = {
    package = mkIf isDarwin null;
    enable = true;
    profiles.default = {
      enableUpdateCheck = false;

      userSettings = {
        # Make start-up less noisy
        "update.showReleaseNotes" = false;
        "workbench.startupEditor" = "none";
        "terminal.integrated.enablePersistentSessions" = false;

        # General/QoL
        "editor.stickyScroll.enabled" = false;
        "terminal.integrated.stickyScroll.enabled" = false;
        "git.blame.editorDecoration.enabled" = true;

        # Code formatting
        "editor.defaultFormatter" = "dprint.dprint";
        "editor.formatOnSave" = true;
        "files.insertFinalNewline" = true;
        "js/ts.preferences.importModuleSpecifierEnding" = "index";

        # Security, or lack thereof
        "security.workspace.trust.enabled" = false;
        "json.schemaDownload.trustedDomains" = {
          "*" = true;
        };

        # Disable telemetry (*sigh*)
        "telemetry.telemetryLevel" = "off";
        "telemetry.feedback.enabled" = false;

        # Disable AI features (*heavier sigh*)
        "chat.disableAIFeatures" = true;
        "chat.agent.enabled" = false;
        "chat.mcp.access" = "none";
        "chat.tools.terminal.enableAutoApprove" = false;
        "git.addAICoAuthor" = "off";
        "workbench.secondarySideBar.defaultVisibility" = "hidden";
        "workbench.editor.empty.hint" = "hidden";
        "terminal.integrated.initialHint" = false;
        "terminal.integrated.suggest.enabled" = false;

        # Extensions
        "zig.zls.enabled" = "on";
        "kdl.enable" = false;
        "qt-core.showWelcomePageOnActivation" = false;
        "qt-qml.qmlls.useQmlImportPathEnvVar" = true;
        "qt-qml.doNotAskForQmllsDownload" = true;
        "qt-qml.qmlls.customExePath" = getExe' pkgs.qt6.qtdeclarative "qmlls";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = getExe pkgs.nixd;
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ (getExe pkgs.nixfmt) ];
            };
          };
        };

        # Associations
        "workbench.editorAssociations" = {
          "{git,gitlens,chat-editing-snapshot-text-model,copilot,git-graph,git-graph-3}:/**/*.qrc" =
            "default";
          "*.qrc" = "qt-core.qrcEditor";
        };
      };

      # TODO: Is it at all worth doing conditional extension inclusion for, e.g. dprint?
      extensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
        aaron-bond.better-comments
        naumovs.color-highlight
        usernamehw.errorlens

        dprint.dprint
        editorconfig.editorconfig

        astro-build.astro-vscode
        denoland.vscode-deno
        golang.go
        jnoortheen.nix-ide
        kdl-org.kdl
        rust-lang.rust-analyzer
        theqtcompany.qt-core
        theqtcompany.qt-qml
        unifiedjs.vscode-mdx
        vue.volar
        ziglang.vscode-zig
      ];
    };
  };
}
