//
//  Destinations.swift
//  Pods
//
//  Created by Damien CHOMAT on 11/05/2017.
//  Copyright © 2017 Smart&Soft. All rights reserved.
//

import Foundation
import SwiftyBeaver

public struct Destinations {

  public static let console: ConsoleDestination = {
    let console = ConsoleDestination()
    console.levelColor.verbose = "⚪️ "
    console.levelColor.debug = "☑️ "
    console.levelColor.info = "🔵 "
    console.levelColor.warning = "🔶 "
    console.levelColor.error = "🔴 "
    
    return console
  }()
}

extension SwiftyBeaver {
  
  public static func removeDestination(_ destination: BaseDestination.Type) {
    if let dest = self.destinations.first(where: { (currentDest) -> Bool in
      return destination == type(of: currentDest)
    }) {
      self.removeDestination(dest)
    }
  }
  
}
