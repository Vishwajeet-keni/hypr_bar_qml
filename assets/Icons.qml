pragma Singleton
import QtQuick

QtObject{
    // Battery Icons
    readonly property var battery: {0:"\uf244", 1:"\uf243", 2:"\uf242", 3:"\uf241", 4:"\uf240", "charging":"\uf0e7"}

    // System Stats Icons
    readonly property var system_stats: {"cpu":"\uf4bc", "mem":"\uf0a0", 
                                         "temp":{"temp-cool"  :"\uf2cb",
                                                 "temp-normal":"\uf2ca",
                                                 "temp-warm"  :"\uf2c9",
                                                 "temp-hot"   :"\uf2c8",
                                                 "temp-crit"  :"\uf2c7"}}
                                
    // Updates
    readonly property string updates: "\uf021"
}