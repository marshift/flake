import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

Scope {
	Variants {
		model: Quickshell.screens

		PanelWindow {
			property var modelData
      		screen: modelData

			anchors {
				bottom: true
				left: true
				right: true
			}
			implicitHeight: 32

			RowLayout {
				spacing: 0
				
				Repeater {
					model: ToplevelManager.toplevels.values
					IconImage {
						required property Toplevel modelData
						source: getTaskbarIconForToplevel(modelData)
						width: 32
						height: 32

						function getTaskbarIconForToplevel(toplevel) {
							const entry = DesktopEntries.heuristicLookup(toplevel.appId);
							return Quickshell.iconPath(entry?.icon, true) ?? "application-x-executable";
						}
					}
				}
			}
		}
	}
}
