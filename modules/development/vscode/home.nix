{
  inputs,
  lib,
  pkgs,
  osConfig,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf mkMerge;
  inherit (pkgs.stdenv.hostPlatform) isDarwin system;
  inherit (lib.meta) getExe getExe';
in
mkIf osConfig.swamp.development.vscode.enable {
  programs.vscode = {
    package = mkIf isDarwin null;
    enable = true;
    profiles.default =
      with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace;
      mkMerge [
        {
          extensions = [
            aaron-bond.better-comments
            naumovs.color-highlight
            usernamehw.errorlens
            editorconfig.editorconfig
            github.vscode-github-actions
          ];

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
            "json.schemaDownload.trustedDomains"."*" = true;

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
          };
        }
        (mkIf osConfig.swamp.development.just.enable {
          extensions = [ nefrob.vscode-just-syntax ];
          userSettings = {
            "vscode-just.justPath" = getExe pkgs.just;
            "vscode-just.lspPath" = getExe pkgs.just-lsp;
          };
        })
        (mkIf osConfig.swamp.development.nix.enable {
          extensions = [ jnoortheen.nix-ide ];
          userSettings = {
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = getExe pkgs.nixd;
            "nix.serverSettings" = {
              "nixd" = {
                "formatting" = {
                  "command" = [ (getExe pkgs.nixfmt) ];
                };
              };
            };
          };
        })
        (mkIf osConfig.swamp.development.rust.enable {
          extensions = [ rust-lang.rust-analyzer ];
          userSettings."rust-analyzer.server.path" = getExe pkgs.rust-analyzer;
        })
        (mkIf osConfig.swamp.development.typst.enable {
          extensions = [ myriad-dreamin.tinymist ];
          userSettings."tinymist.serverPath" = getExe pkgs.tinymist;
          # TODO: Can I make it use the system Typst compiler?
        })
        (mkIf osConfig.swamp.development.dprint.enable {
          extensions = [ dprint.dprint ];
          userSettings."dprint.path" = getExe config.programs.dprint.package;
        })
        (mkIf osConfig.swamp.development.javascript.enable {
          extensions = [
            denoland.vscode-deno
            astro-build.astro-vscode
            unifiedjs.vscode-mdx
            kdl-org.kdl # I only really use this for dune but maybe move later?
          ];
          userSettings = {
            "deno.path" = getExe pkgs.deno;
            "js/ts.tsserver.node.path" = getExe pkgs.nodejs;
            "kdl.enable" = false; # Stupid fucking language server go away
          };
        })
        (mkIf osConfig.swamp.development.qt.enable {
          extensions = [
            theqtcompany.qt-core
            theqtcompany.qt-qml
          ];
          userSettings = {
            "qt-core.showWelcomePageOnActivation" = false;
            "qt-qml.qmlls.useQmlImportPathEnvVar" = true;
            "qt-qml.doNotAskForQmllsDownload" = true;
            "qt-qml.qmlls.customExePath" = getExe' pkgs.qt6.qtdeclarative "qmlls";

            # Associations
            "workbench.editorAssociations" = {
              "{git,gitlens,chat-editing-snapshot-text-model,copilot,git-graph,git-graph-3}:/**/*.qrc" =
                "default";
              "*.qrc" = "qt-core.qrcEditor";
            };
          };
        })
      ];
  };
}
