//
//  SegmentControlCell.swift
//  SwiftyBeaver-Destinations
//
//  Created by Damien CHOMAT on 09/05/2017.
//  Copyright © 2017 Smart&Soft. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import SwiftyBeaver

protocol SegmentedControlDelegate: class {
  func segmentedControlCell(_ cell: SegmentedControlCell, logLevelChangedTo level: SwiftyBeaver.Level)
}

final class SegmentedControlCell: UITableViewCell, Reusable {
  
  @IBOutlet weak var ibSegmentedControl: UISegmentedControl!
  fileprivate weak var delegate: SegmentedControlDelegate?
  
  func fill(logLevel: SwiftyBeaver.Level, delegate: SegmentedControlDelegate? = nil) {
    self.ibSegmentedControl.selectedSegmentIndex = logLevel.rawValue
    self.delegate = delegate
  }
  
  @IBAction func changeLogLevel(_ sender: UISegmentedControl) {
    guard let logLevel = SwiftyBeaver.Level(rawValue: sender.selectedSegmentIndex) else {
      return
    }
    self.delegate?.segmentedControlCell(self, logLevelChangedTo: logLevel)
  }
  
}
