//
//  AppDelegate.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 15/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let signUpViewController = SignUpViewController(signUpView: SignUpView())
        window.rootViewController = signUpViewController
        
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
    
}
