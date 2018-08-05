//
//  KeyCode.swift
//  KeyCommander
//
//  Created by Hori,Masaki on 2018/08/05.
//  Copyright © 2018年 Hori,Masaki. All rights reserved.
//

import Foundation

import Carbon

struct KeyCode {
    
    let code: UInt16
}

extension KeyCode: CustomStringConvertible {
    
    var description: String {
        
        switch code {
            
        case 123: return "←"
            
        case 124: return "→"
            
        case 125: return "↓"
            
        case 126: return "↑"
                        
        default:
            
            return keyName(scanCode: code) ?? ""
        }
    }
}

struct Command {
    
    let command: [KeyCode]
}

extension Command: CustomStringConvertible {
    
    var description: String {
        
        return command.reduce("") { $0 + $1.description }
    }
}

func keyName(scanCode: UInt16) -> String? {
    
    let maxNameLength = 4
    var nameBuffer = [UniChar](repeating: 0, count : maxNameLength)
    var nameLength = 0
    
    let modifierKeys = UInt32(alphaLock >> 8) & 0xFF // Caps Lock
    var deadKeys: UInt32 = 0
    let keyboardType = UInt32(LMGetKbdType())
    
    let source = TISCopyCurrentKeyboardLayoutInputSource().takeRetainedValue()
    guard let ptr = TISGetInputSourceProperty(source, kTISPropertyUnicodeKeyLayoutData) else {
        NSLog("Could not get keyboard layout data")
        return nil
    }
    let layoutData = Unmanaged<CFData>.fromOpaque(ptr).takeUnretainedValue() as Data
    let osStatus = layoutData.withUnsafeBytes {
        UCKeyTranslate($0, scanCode, UInt16(kUCKeyActionDown),
                       modifierKeys, keyboardType, UInt32(kUCKeyTranslateNoDeadKeysMask),
                       &deadKeys, maxNameLength, &nameLength, &nameBuffer)
    }
    guard osStatus == noErr else {
        NSLog("Code: 0x%04X  Status: %+i", scanCode, osStatus);
        return nil
    }
    
    return  String(utf16CodeUnits: nameBuffer, count: nameLength)
}
