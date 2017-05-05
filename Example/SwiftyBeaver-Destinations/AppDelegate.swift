//
//  AppDelegate.swift
//  SwiftyBeaver-SNSExtensions
//
//  Created by Damien CHOMAT on 03/05/2017.
//  Copyright © 2017 Damien CHOMAT. All rights reserved.
//

import UIKit
import SwiftyBeaver

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    Config.SwiftyBeaver.setup()
    return true
  }

}
