{
  lib,
  osConfig,
  ...
}:
let
  inherit (lib) toJSON;
in
{
  imports = [ ./_module.nix ];

  programs.vrcx = {
    inherit (osConfig.swamp.gaming.vr.vrcx) enable;

    config = {
      "config:vrcx_onboarding_welcome_seen" = "true";
      "config:vrcx_thememode" = "midnight";
      "config:vrcx_themecolor" = "red";
      "config:vrcx_selfinviteoverride" = "true"; # VRChat broke launch URLs on Linux and never fixed them!
      "config:vrcx_showinstanceidinlocation" = "true";
      "config:vrcx_shownewdashboardbutton" = "false";
      "config:vrcx_hideusermemos" = "true";
      "config:vrcx_avatarremotedatabase" = "false";

      "config:vrcx_sidebardividebyfriendgroup" = "true";
      "config:vrcx_sameinstanceabovefavorites" = "true";
      "config:vrcx_hidefriendsinsameinstance" = "true";
      "config:vrcx_sidebargroupbyinstance" = "true";

      "config:vrcx_accessiblestatusindicators" = "true";
      "config:vrcx_hidenicknames" = "true";

      "config:sharedfeedfilters" = toJSON {
        noty = {
          Location = "Off";

          OnPlayerJoined = "Friends";
          OnPlayerLeft = "Friends";
          OnPlayerJoining = "Friends";

          Online = "Off";
          Offline = "Off";
          GPS = "Off";
          Status = "Off";

          invite = "Off";
          requestInvite = "Off";
          inviteResponse = "Off";
          requestInviteResponse = "Off";

          boop = "Off";

          friendRequest = "Off";
          Friend = "Off";
          Unfriend = "On";

          DisplayName = "Off";
          TrustLevel = "Off";

          groupChange = "On";
          "group.announcement" = "Off";
          "group.informative" = "On";
          "group.invite" = "On";
          "group.joinRequest" = "Off";
          "group.transfer" = "Off";
          "group.queueReady" = "On";

          "instance.closed" = "Off";

          PortalSpawn = "Everyone";
          Event = "On";
          External = "Off";
          VideoPlay = "Off";

          BlockedOnPlayerJoined = "Off";
          BlockedOnPlayerLeft = "Off";
          MutedOnPlayerJoined = "Off";
          MutedOnPlayerLeft = "Off";

          AvatarChange = "Everyone";
          ChatBoxMessage = "Off";
          Blocked = "Off";
          Unblocked = "Off";
          Muted = "Off";
          Unmuted = "Off";
        };

        wrist = {
          Location = "On";

          OnPlayerJoined = "Everyone";
          OnPlayerLeft = "Everyone";
          OnPlayerJoining = "Friends";

          Online = "Friends";
          Offline = "Friends";
          GPS = "Friends";
          Status = "Friends";

          invite = "Friends";
          requestInvite = "Friends";
          inviteResponse = "Friends";
          requestInviteResponse = "Friends";

          boop = "Friends";

          friendRequest = "On";
          Friend = "On";
          Unfriend = "On";

          DisplayName = "Friends";
          TrustLevel = "Friends";

          groupChange = "On";
          "group.announcement" = "On";
          "group.informative" = "On";
          "group.invite" = "On";
          "group.joinRequest" = "On";
          "group.transfer" = "On";
          "group.queueReady" = "On";

          "instance.closed" = "On";

          PortalSpawn = "Everyone";
          Event = "On";
          External = "On";
          VideoPlay = "On";

          BlockedOnPlayerJoined = "Off";
          BlockedOnPlayerLeft = "Off";
          MutedOnPlayerJoined = "Off";
          MutedOnPlayerLeft = "Off";

          AvatarChange = "Everyone";
          ChatBoxMessage = "Off";
          Blocked = "On";
          Unblocked = "On";
          Muted = "On";
          Unmuted = "On";
        };
      };

      "config:vrcx_udonexceptionlogging" = "true";
      "config:vrcx_logresourceload" = "true"; # I see you Popcorn Palace
    };
  };
}
