//
//  SelectOptions.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 01/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import UIKit

protocol Options {
   func options(on button: UIButton, buttons: [UIButton]!, parameters: inout String)
}
extension Options {
   func options(on button: UIButton, buttons: [UIButton]!, parameters: inout String) {
      button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
      button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
      guard let value = button.titleLabel?.text as String? else { return }
      if !button.isSelected && value == "Any" {
         parameters.removeAll()
         resetButtons(sender: button, buttons: buttons)
      } else {
         saveValues(sender: button, value: value, parameters: &parameters)
      }
   }
   
   func saveValues(sender: UIButton, value: String, parameters: inout String){
      if !sender.isSelected {
         sender.isSelected = true
         sender.backgroundColor = #colorLiteral(red: 0.1503180861, green: 1, blue: 0.4878128767, alpha: 1)
         parameters.append(value.lowercased() + ",")
      }  else if sender.isSelected {
         sender.isSelected = false
         sender.backgroundColor = #colorLiteral(red: 1, green: 0.3724520802, blue: 0.3093305528, alpha: 1)
         if let range = parameters.range(of: value + ",") {
            parameters.removeSubrange(range)
         }
      }
   }
   
   func resetButtons(sender: UIButton, buttons: [UIButton]!) {
      sender.isSelected = true
      sender.backgroundColor = #colorLiteral(red: 0.1503180861, green: 1, blue: 0.4878128767, alpha: 1)
      for button in buttons where button.titleLabel!.text != "Any" {
         button.isSelected = false
         button.backgroundColor = #colorLiteral(red: 1, green: 0.3724520802, blue: 0.3093305528, alpha: 1)
      }
   }
   
   func removeAll() {
      PetService.shared.parameters.age.removeAll()
      PetService.shared.parameters.breed.removeAll()
      PetService.shared.parameters.color.removeAll()
      PetService.shared.parameters.environnement.removeAll()
      PetService.shared.parameters.gender.removeAll()
      PetService.shared.parameters.size.removeAll()
   }
   
   private func deleteOption(on value: String, parameters: inout String) {
      if let range = parameters.range(of: value + ",") {
         parameters.removeSubrange(range)
      }
   }
   
   
}
