pragma Singleton

import QtQuick
import qs.states

QtObject {

    property QtObject bar: QtObject {

        property bool topRightAngleVisible: true

    }

    property QtObject powerPopup: QtObject {

        property bool popupVisible: false

    }

}
