//
//  LogEntriesDestination.swift
//  SwiftyBeaver-SNSExtensions
//
//  Created by Damien CHOMAT on 03/05/2017.
//  Copyright © 2017 Smart&Soft. All rights reserved.
//

import Foundation
import SwiftyBeaver
import iOSLogEntries

public final class LogEntriesDestination: BaseDestination {
  
  fileprivate var leLog: LELog
  fileprivate var level: SwiftyBeaver.Level
  
  public init(token: String, level: SwiftyBeaver.Level) {
    self.leLog = LELog.session(withToken: token)
    self.leLog.logApplicationLifecycleNotifications = false
    self.level = level
  }
  
  public override func send(_ level: SwiftyBeaver.Level, msg: String, thread: String, file: String, function: String, line: Int) -> String? {
    
    let dict = LogUtils.formatMessage(level: level, msg: msg, thread: thread, file: file, function: function, line: line)
    
    guard let jsonString = LogUtils.jsonStringFromDict(dict) else {
      debugPrint("LogEntriesDestination - serialization issue")
      return nil
    }
    
    if level.rawValue >= self.level.rawValue {
      self.leLog.log(jsonString as NSObject)
    }
    
    return jsonString
  }
  
}
