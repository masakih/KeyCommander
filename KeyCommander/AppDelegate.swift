//
//  AppDelegate.swift
//  KeyCommander
//
//  Created by Hori,Masaki on 2018/08/04.
//  Copyright © 2018年 Hori,Masaki. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    private var mainWindowController = MainWindowController()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        mainWindowController.showWindow(nil)
    }
}

