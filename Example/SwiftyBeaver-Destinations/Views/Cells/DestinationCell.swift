//
//  DestinationCell.swift
//  SwiftyBeaver-Destinations
//
//  Created by Damien CHOMAT on 09/05/2017.
//  Copyright © 2017 Smart&Soft. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import SwiftyBeaver
import SwiftyBeaver_Destinations

enum CustomDestination: Int {
  case console
  case logmatic
  case logEntries
  
  func name() -> String {
    switch self {
    case .console:
      return "Console"
    case .logmatic:
      return "Logmatic"
    case .logEntries:
      return "Logentries"
    }
  }
  
  func destination() -> BaseDestination.Type {
    switch self {
    case .console:
      return ConsoleDestination.self
    case .logmatic:
      return LogmaticDestination.self
    case .logEntries:
      return LogEntriesDestination.self
    }
  }
  
}

protocol DestinationCellDelegate: class {
  func destinationCell(_ cell: DestinationCell, stateChangedTo newState: Bool)
}

final class DestinationCell: UITableViewCell, NibReusable {
  
  @IBOutlet weak var ibNameLabel: UILabel!
  @IBOutlet weak var ibStateSwitch: UISwitch!
  
  var destination: CustomDestination?
  weak var delegate: DestinationCellDelegate?
  
  public func fill(destination: CustomDestination, delegate: DestinationCellDelegate, state: Bool = true) {
    self.destination = destination
    self.ibNameLabel.text = destination.name()
    self.ibStateSwitch.setOn(state, animated: true)
    self.delegate = delegate
  }
  
  @IBAction func stateChanged(_ sender: UISwitch) {
    self.delegate?.destinationCell(self, stateChangedTo: sender.isOn)
  }
  
}
