//
//  LogmaticDestination.swift
//  SwiftyBeaver-SNSExtensions
//
//  Created by Damien CHOMAT on 03/05/2017.
//  Copyright © 2017 Smart&Soft. All rights reserved.
//

import Foundation
import SwiftyBeaver
import Logmatic

public final class LogmaticDestination: BaseDestination {
  
  fileprivate var level: SwiftyBeaver.Level
  
  public init(apiKey: String, level: SwiftyBeaver.Level) {
    if let logger = LMLogger.shared() {
      logger.key = apiKey
      logger.start()
      logger.logLevel = LogmaticDestination.adaptLogLevel(level: level)
    }
    self.level = level
  }
  
  public override func send(_ level: SwiftyBeaver.Level, msg: String, thread: String, file: String, function: String, line: Int) -> String? {
  
    let dict = LogUtils.formatMessage(level: level, msg: msg, thread: thread, file: file, function: function, line: line)
    
    guard let jsonString = LogUtils.jsonStringFromDict(dict) else {
      debugPrint("LogEntriesDestination - serialization issue")
      return nil
    }
    
    if level.rawValue >= self.level.rawValue {
      LMLogger.shared()?.log(nil, withMessage: jsonString)
    }
    
    return jsonString
  }
  
  fileprivate static func adaptLogLevel(level: SwiftyBeaver.Level) -> LMLogLevel {
    var logLevel: LMLogLevel
    switch level {
    case .debug:
      logLevel = .verbose
    case .verbose:
      logLevel = .verbose
    case .info:
      logLevel = .verbose
    case .warning:
      logLevel = .short
    case .error:
      logLevel = .short
    }
    
    return logLevel
  }
  
}
