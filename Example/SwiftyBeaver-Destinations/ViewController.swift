//
//  ViewController.swift
//  SwiftyBeaver-SNSExtensions
//
//  Created by Damien CHOMAT on 03/05/2017.
//  Copyright © 2017 Damien CHOMAT. All rights reserved.
//

import UIKit
import SwiftyBeaver
import SwiftyBeaver_Destinations

enum MainControllerSections: Int {
  case message
  case filter
  case destinations
}

class ViewController: UIViewController {
  
  // Outlets
  @IBOutlet weak var ibTableView: UITableView!
  @IBOutlet weak var ibSendLogButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.ibTableView.delegate = self
    self.ibTableView.dataSource = self
    self.ibTableView.register(cellType: DestinationCell.self)
  }
  
  @IBAction func sendLog(_ sender: Any) {
    let messageIndex = IndexPath(row: 0, section: 0)
    let logLevelIndex = IndexPath(row: 1, section: 0)
    // Get message and log level from message configuration section
    guard let msgCell =  self.ibTableView.cellForRow(at: messageIndex) as? TextFieldCell,
      let segmentCell = self.ibTableView.cellForRow(at: logLevelIndex) as? SegmentedControlCell,
      let logLevel = SwiftyBeaver.Level(rawValue: segmentCell.ibSegmentedControl.selectedSegmentIndex),
      let message = msgCell.ibMessageTextField.text else {
        return
    }
    self.sendMessage(message: message, forLogLevel: logLevel)
  }
  
  fileprivate func sendMessage(message: String, forLogLevel level: SwiftyBeaver.Level) {
    switch level {
    case .verbose:
      log.verbose(message)
    case .debug:
      log.debug(message)
    case .info:
      log.info(message)
    case .warning:
      log.warning(message)
    case .error:
      log.error(message)
    }
  }
  
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
  
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let section = MainControllerSections(rawValue: section) else {
      return nil
    }
    switch section {
    case .message:
      return "Configuration du message"
    case .filter:
      return "Filtrage du message envoyé"
    case .destinations:
      return "Destinations"
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let currentSection = MainControllerSections(rawValue: section) else {
      return 0
    }
    switch currentSection {
    case .message:
      return 2
    case .filter:
      return 1
    case .destinations:
      return log.destinations.count
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  /**
   Section 1: Message / Log level
   Section 2: Minimum log level to filter
   Section 3: Destinations
   */
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let currentSection = MainControllerSections(rawValue: indexPath.section) else {
      return UITableViewCell()
    }
    switch currentSection {
    case .message:
      return self.prepareFirstSection(tableView, indexPath: indexPath)
    case .filter:
      let cell = tableView.dequeueReusableCell(for: indexPath) as SegmentedControlCell
      cell.fill(logLevel: .verbose, delegate: self)
      return cell
    case .destinations:
      let cell = tableView.dequeueReusableCell(for: indexPath) as DestinationCell
      if let destination = CustomDestination(rawValue: indexPath.row) {
        cell.fill(destination: destination, delegate: self)
      }
      
      return cell
      
    }
  }
  
  fileprivate func prepareFirstSection(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(for: indexPath) as TextFieldCell
      cell.fill(message: "Default log message")
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(for: indexPath) as SegmentedControlCell
      cell.fill(logLevel: .verbose)
      return cell
    default:
      return UITableViewCell()
    }
  }
  
}

// MARK: - SegmentedControlDelegate
extension ViewController: SegmentedControlDelegate {
  /**
   Filtering messages to send by a specific log level set by the user
   */
  func segmentedControlCell(_ cell: SegmentedControlCell, logLevelChangedTo level: SwiftyBeaver.Level) {
    log.destinations.forEach { (destination) in
      destination.minLevel = level
    }
  }
}

// MARK: - DestinationCellDelegate
extension ViewController: DestinationCellDelegate {
  
  /**
   Add or remove destinations from the logger depends on the switch state
   */
  func destinationCell(_ cell: DestinationCell, stateChangedTo newState: Bool) {
    if let destEnum = cell.destination {
      newState ? self.addDestination(destEnum) : log.removeDestination(destEnum.destination())
    }
  }
  
  fileprivate func addDestination(_ dest: CustomDestination) {
    let filterLogLevelIndex = IndexPath(row: 0, section: 1)
    guard let segmentCell = self.ibTableView.cellForRow(at: filterLogLevelIndex) as? SegmentedControlCell,
      let level = SwiftyBeaver.Level(rawValue: segmentCell.ibSegmentedControl.selectedSegmentIndex) else {
        return
    }
    
    switch dest {
    case .console:
      log.addDestination(Destinations.console)
    case .logmatic:
      log.addDestination(LogmaticDestination(apiKey: Environment.logmaticTestApiKey, level: level))
    case .logEntries:
      log.addDestination(LogEntriesDestination(token: Environment.logentriesTestToken, level: level))
    }
  }
  
}
