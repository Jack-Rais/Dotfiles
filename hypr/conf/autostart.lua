
hl.on("hyprland.start", function ()

    hl.exec_cmd("dms run")

    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("systemctl --user start hyprland-session.target")

    hl.exec_cmd("/usr/lib/xdg-desktop-portal &")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland &")

end)
