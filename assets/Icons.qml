pragma Singleton
import QtQuick

QtObject{
    // Updates
    readonly property string updates: "\u{f021}"

    // Menu
    readonly property string menu: "\u{F07E1}"


    // Battery Icons
    readonly property var battery: {
        "lvl":{0:"\u{f244}", 1:"\u{f243}", 2:"\u{f242}", 3:"\u{f241}", 4:"\u{f240}"}, 
        "Charging":"\u{f0e7}", "PowerSaver":"\u{f06c}", "Performance":"\u{f0e4}"
    }

    // System Stats Icons
    readonly property var system_stats: {"cpu":"\u{f4bc}", "mem":"\u{f0a0}", 
                                         "temp":{"temp-cool"  :"\u{f2cb}",
                                                 "temp-normal":"\u{f2ca}",
                                                 "temp-warm"  :"\u{f2c9}",
                                                 "temp-hot"   :"\u{f2c8}",
                                                 "temp-crit"  :"\u{f2c7}"}}

    function tempIcon(state) {return system_stats.temp[state] || system_stats.temp["temp-cool"]}
}