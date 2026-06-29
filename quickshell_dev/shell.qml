import QtQuick
import Quickshell

import "widgets/bar"
import "widgets/wallpaper"


ShellRoot {
    id: shell

    Variants {
        model: Quickshell.screens
        delegate: Wallpaper {}
    }

    Variants {
        model: Quickshell.screens
        delegate: Bar {}
    }

}
