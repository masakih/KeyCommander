//
//  SetupModeTest.swift
//  KeyCommanderTests
//
//  Created by Hori,Masaki on 2018/08/04.
//  Copyright © 2018年 Hori,Masaki. All rights reserved.
//

import XCTest

@testable import KeyCommander

class SetupModeTest: XCTestCase {

    func testInput() {
        
        let list: [UInt16] = [90, 65, 4, 0, 56]
        
        let setupMode = SetupMode()
        
        list.forEach(setupMode.input)
        
        XCTAssert(setupMode.list == list)
    }

}
