//
//  BreedsTableViewCell.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 01/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import Foundation

class BreedsTableViewCell: UITableViewCell{
   @IBOutlet var breedButtons: UIButton!
   @IBAction func breedAction(_ sender: UIButton) {
//      PetService.shared.parameters.breed.append(options(on: sender).joined(separator: ","))
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      breedButtons.setImage(UIImage(named: "checkButtonOFF"), for: .normal)
      breedButtons.setImage(UIImage(named: "checkButtonON"), for: .selected)
   }
//   func options(on button: UIButton) -> String {
//      var values = String()
//      button.setImage(UIImage(named: "checkButtonOFF"), for: .normal)
//      button.setImage(UIImage(named: "checkButtonON"), for: .selected)
//      guard let name = button.title(for: .normal) else { return ""}
//      if !button.isSelected {
//         button.isSelected = true
//         values += name + ","
//      } else {
//         button.isSelected = false
//         values = values.replacingOccurrences(of: name + ",", with: "")
//      }
//      print(values)
//      return values
//   }
}

