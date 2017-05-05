//
//  LabelCell.swift
//  SwiftyBeaver-Destinations
//
//  Created by Damien CHOMAT on 09/05/2017.
//  Copyright © 2017 Smart&Soft. All rights reserved.
//

import Foundation
import UIKit
import Reusable

final class TextFieldCell: UITableViewCell, Reusable {
  
  @IBOutlet weak var ibMessageTextField: UITextField!
  
  func fill(message: String) {
    self.ibMessageTextField.text = message
  }
  
}
