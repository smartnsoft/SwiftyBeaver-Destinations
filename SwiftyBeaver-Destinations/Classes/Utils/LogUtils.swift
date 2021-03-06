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
import UIKit
import SwiftyBeaver

final class LogUtils {
  
  public static func formatMessage(level: SwiftyBeaver.Level, msg: String, thread: String, file: String, function: String, line: Int) -> [String: Any] {
    return [
      "timestamp": Date().timeIntervalSince1970,
      "level": level.rawValue,
      "message": msg,
      "thread": thread,
      "fileName": file.components(separatedBy: "/").last ?? "Unknwown",
      "function": function,
      "line": line]
  }
  
  /**
   Serialization method for 'Dictionary' object
   
   -returns: 'String' log message
   */
  static func jsonStringFromDict(_ dict: [String: Any]) -> String? {
    var jsonString: String?
    
    // try to create JSON string
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
      jsonString = String(data: jsonData, encoding: .utf8)
    } catch {
      print("SwiftyBeaver could not create JSON from dict.")
    }
    return jsonString
  }
  
  /**
   Extract all data about user's device
   
   -returns: 'Dictionary' device's information
   */
  static func deviceDetails() -> [String: String] {
    var details = [String: String]()
    
    let osVersion = ProcessInfo.processInfo.operatingSystemVersion
    var osVersionStr = String(osVersion.majorVersion)
    osVersionStr += "." + String(osVersion.minorVersion)
    osVersionStr += "." + String(osVersion.patchVersion)
    details["osVersion"] = osVersionStr
    details["hostName"] = ProcessInfo.processInfo.hostName
    details["deviceName"] = UIDevice.current.name
    details["deviceModel"] = UIDevice.current.model
    
    return details
  }
  
  /**
   Extract the current thread name if we are not on the main thread
   
   -returns: 'String' current thread
   */
  class func threadName() -> String {
    if Thread.isMainThread {
      return ""
    } else {
      let threadName = Thread.current.name
      if let threadName = threadName, !threadName.isEmpty {
        return threadName
      } else {
        return String(format: "%p", Thread.current)
      }
    }
  }
  
}
