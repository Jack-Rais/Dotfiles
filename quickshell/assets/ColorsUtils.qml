import QtQuick
pragma Singleton

QtObject {
    
    function withAlpha(color, alpha) {
        return Qt.hsla(color.hslHue, color.hslSaturation, color.hslLightness, alpha);
    }

}
