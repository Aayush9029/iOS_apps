// Key board simulator
//
//  KeyPress.swift
//  Rifi
//
//  Created by Aayush Pokharel on 2020-04-06.
//  Copyright © 2020 Aayush Pokharel. All rights reserved.
//

import AppKit

class KeyPress {

    let src = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)
    let loc = CGEventTapLocation.cghidEventTap
    var keys = [String: UInt16]()
    
    init() {
        keys = [
        "Return"           : 0x24,
        "Tab"              : 0x30,
        "Space"            : 0x31,
        "Delete"           : 0x33,
        "Escape"           : 0x35,
        "Command"          : 0x37,
        "Shift"            : 0x38,
        "CapsLock"         : 0x39,
        "Option"           : 0x3A,
        "Control"          : 0x3B,
        "RightCommand"     : 0x36,
        "RightShift"       : 0x3C,
        "RightOption"      : 0x3D,
        "RightControl"     : 0x3E,
        "Function"         : 0x3F,
        "F17"              : 0x40,
        "VolumeUp"         : 0x48,
        "VolumeDown"       : 0x49,
        "Mute"             : 0x4A,
        "F18"              : 0x4F,
        "F19"              : 0x50,
        "F20"              : 0x5A,
        "F5"               : 0x60,
        "F6"               : 0x61,
        "F7"               : 0x62,
        "F3"               : 0x63,
        "F8"               : 0x64,
        "F9"               : 0x65,
        "F11"              : 0x67,
        "F13"              : 0x69,
        "F16"              : 0x6A,
        "F14"              : 0x6B,
        "F10"              : 0x6D,
        "F12"              : 0x6F,
        "F15"              : 0x71,
        "Help"             : 0x72,
        "Home"             : 0x73,
        "PageUp"           : 0x74,
        "ForwardDelete"    : 0x75,
        "F4"               : 0x76,
        "End"              : 0x77,
        "F2"               : 0x78,
        "PageDown"         : 0x79,
        "F1"               : 0x7A,
        "LeftArrow"        : 0x7B,
        "RightArrow"       : 0x7C,
        "DownArrow"        : 0x7D,
        "UpArrow"          : 0x7E
    ];



    }
    func press(key: String){
        
        let key = key.capitalized
        
        if keys[key] != nil {  } else{ print("Error: Key Not Found!"); return }
        sleep(5)
        CGEvent(keyboardEventSource: src,  virtualKey: keys[key]! ,keyDown: true)?.post(tap: loc)
        CGEvent(keyboardEventSource: src,  virtualKey: keys[key]!,   keyDown: false)?.post(tap: loc)
    }

}
