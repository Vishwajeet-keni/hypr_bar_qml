import QtQuick
import "../../config"

Image {
    id: logo
    source: "../assets/archlinux-logo.svg"
    sourceSize.width: Vars.fontLogo * 1.2
    sourceSize.height: Vars.fontLogo * 1.2
    fillMode: Image.PreserveAspectFit
    smooth: true
    antialiasing: true
}