// The MIT License (MIT)
//
// Copyright (c) 2017 Smart&Soft
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
  
  public override func send(_ level: SwiftyBeaver.Level, msg: String, thread: String, file: String, function: String, line: Int, context: Any?) -> String? {
  
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
