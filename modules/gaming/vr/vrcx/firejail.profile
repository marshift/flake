# Lock down VRCX to the bare minimum
# TODO: Network filters to only allow relevant domains?
ignore novideo

ignore noexec /tmp

noblacklist ${HOME}/.config/VRCX
noblacklist ${HOME}/.cache/VRCX
noblacklist ${HOME}/Pictures/VRCX

mkdir ${HOME}/.config/VRCX
whitelist ${HOME}/.config/VRCX

mkdir ${HOME}/.cache/VRCX
whitelist ${HOME}/.cache/VRCX/

mkdir ${HOME}/Pictures/VRCX/
whitelist ${HOME}/Pictures/VRCX/

# TODO: Use VRChat media folder rather than hardcode
whitelist /mnt/data/games/steam/steamapps/compatdata/438100/pfx/drive_c/users/steamuser/AppData/LocalLow/VRChat/VRChat/
whitelist /mnt/data/games/steam/steamapps/compatdata/438100/pfx/drive_c/users/steamuser/Pictures/VRChat/

private-etc @tls-ca

dbus-user filter
dbus-user.talk org.freedesktop.Notifications

# Allow tray icon at the cost of a potential sandbox escape
# https://github.com/netblue30/firejail/discussions/4053
dbus-user.talk org.kde.StatusNotifierWatcher

ignore dbus-user none

include electron-common.profile
