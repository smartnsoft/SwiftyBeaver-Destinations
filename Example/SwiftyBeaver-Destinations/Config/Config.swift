//
//  SBConfig.swift
//  SwiftyBeaver-Destinations
//
//  Created by Damien CHOMAT on 09/05/2017.
//  Copyright © 2017 Smart&Soft. All rights reserved.
//

import Foundation
import SwiftyBeaver
import SwiftyBeaver_Destinations

struct Config {
  
  struct SwiftyBeaver {
    
    static let logentries: LogEntriesDestination = {
      return LogEntriesDestination(token: Environment.logentriesTestToken, level: .verbose)
    }()
    
    static let logmatic: LogmaticDestination = {
      return LogmaticDestination(apiKey: Environment.logmaticTestApiKey, level: .verbose)
    }()
    
    static func setup() {
      log.addDestination(Destinations.console)
      log.addDestination(logentries)
      log.addDestination(logmatic)
      
    }
    
  }
  
}
