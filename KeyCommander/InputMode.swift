//
//  InputMode.swift
//  KeyCommander
//
//  Created by Hori,Masaki on 2018/08/04.
//  Copyright © 2018年 Hori,Masaki. All rights reserved.
//

import Foundation

private class ResetOperation: Operation {
    
    let resetTime: TimeInterval
    let resetFunction: () -> Void
    
    init(_ resetTime: TimeInterval, resetFunc: @escaping () -> Void) {
        
        self.resetTime = resetTime
        self.resetFunction = resetFunc
    }
    
    override func main() {
        
        while resetTime > Date().timeIntervalSince1970 {
            
            if isCancelled {
                
                return
            }
        }
        
        resetFunction()
    }
}

class InputMode: Mode {
    
    private let keyList: [UInt16]
    private let listCount: Int
    private let completeHandler: () -> Void
    
    private let waitTime = 0.3
    private var wating = false
    private let operationQueue = OperationQueue()
    private var resetOperation: ResetOperation?
    
    private var cursor: Int = 0
    
    init(_ keyList: [UInt16], completeHandler: @escaping () -> Void = {}) {
        
        self.keyList = keyList
        self.listCount = keyList.count
        self.completeHandler = completeHandler
    }
    
    func input(_ key: UInt16) {
        
        guard !wating else {
            
            reset()
            return
        }
        
        guard key == keyList[cursor] else {
            
            reset()
            return
        }
            
        cursor += 1
        
        if cursor == listCount {
            
            completeHandler()
            
            reset()
        }
    }
    
    private func reset() {
        
        cursor = 0
        
        wating = true
        
        resetOperation?.cancel()
        resetOperation = ResetOperation(Date().timeIntervalSince1970 + waitTime) {
            
            self.wating = false
        }
        operationQueue.addOperation(resetOperation!)
    }
}
