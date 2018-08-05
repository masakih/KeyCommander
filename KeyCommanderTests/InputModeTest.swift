//
//  InputModeTest.swift
//  KeyCommanderTests
//
//  Created by Hori,Masaki on 2018/08/04.
//  Copyright © 2018年 Hori,Masaki. All rights reserved.
//

import XCTest

@testable import KeyCommander

class InputModeTest: XCTestCase {

    func testSuccess() {
        
        var completed = false
        
        let list: [UInt16] = [30, 54, 33, 66]
        
        let inputMode = InputMode(list) {
            
            completed = true
        }
        
        list.forEach(inputMode.input)
        
        XCTAssert(completed)
    }
    
    func testSuccess2() {
        
        var completed = false
        
        let list: [UInt16] = [30, 54, 33, 66]
        
        let inputMode = InputMode(list) {
            
            completed = true
        }
        
        inputMode.input(3)
        sleep(1)
        list.forEach(inputMode.input)
        
        XCTAssert(completed)
    }
    
    func testFailure() {
        
        var completed = false
        
        let list: [UInt16] = [30, 54, 33, 66]
        
        let inputMode = InputMode(list) {
            
            completed = true
        }
        
        inputMode.input(30)
        inputMode.input(33)
        inputMode.input(66)
        
        XCTAssertFalse(completed)
    }
    
    func testFailure2() {
        
        var completed = false
        
        let list: [UInt16] = [30, 54, 33, 66]
        
        let inputMode = InputMode(list) {
            
            completed = true
        }
        
        inputMode.input(3)
        list.forEach(inputMode.input)
        
        XCTAssertFalse(completed)
    }
}
