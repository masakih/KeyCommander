//
//  SetupMode.swift
//  KeyCommander
//
//  Created by Hori,Masaki on 2018/08/04.
//  Copyright © 2018年 Hori,Masaki. All rights reserved.
//

import Foundation

class SetupMode: Mode {
    
    private(set) var list: [UInt16] = []
    
    private var handler: ([UInt16]) -> Void
    
    init(_ handler: @escaping ([UInt16]) -> Void = {_ in}) {
        
        self.handler = handler
    }
    
    func input(_ key: UInt16) {
        
        list += [key]
        
        handler(list)
    }
}
