//
//  CommandViewController.swift
//  KeyCommander
//
//  Created by Hori,Masaki on 2018/08/04.
//  Copyright © 2018年 Hori,Masaki. All rights reserved.
//

import Cocoa

class CommandViewController: NSViewController {
    
    @objc dynamic private var buttonTitle: String? = "Record"
    
    @objc dynamic private var message: String = ""
    
    @objc dynamic private var command: String = ""
    
    private var mode: Mode = InputMode([])
    
    
    override var nibName: NSNib.Name {
        
        return NSNib.Name("CommandViewController")
    }
    
    override func viewDidAppear() {
        
        view.window?.makeFirstResponder(self)
    }
    
    override func keyDown(with event: NSEvent) {
        
        mode.input(event.keyCode)
    }
    
    @IBAction private func clickButton(_: Any) {
        
        message = ""
        
        mode = nextMode()
        
        buttonTitle = getButtonTitle()
    }
    
    private func nextMode() -> Mode {
        
        switch mode {
            
        case _ as InputMode:
            
            return SetupMode() { [weak self] list in
                
                self?.command = Command(command: list.map({ KeyCode(code: $0) })).description
            }
            
        case let m as SetupMode:
            
            return InputMode(m.list) { [weak self] in
                
                self?.message = "Complete!"
            }
            
        default:
        
            fatalError("Current mode is unknown")
        }
    }
    
    private func getButtonTitle() -> String {
        
        switch mode {
            
        case _ as InputMode: return "Record"
            
        case _ as SetupMode: return "Stop"
            
        default: return ""
        }
    }
    
}
