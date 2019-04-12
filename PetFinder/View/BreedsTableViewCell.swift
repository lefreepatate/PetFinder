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
   @IBOutlet var breedBtn: UIButton!
   @IBAction func breedAction(_ sender: UIButton) {
      guard var name = breedBtn.titleLabel?.text else {return}
      name = name.replacingOccurrences(of: " ", with: "%20")
      if !breedBtn.isSelected {
         breedBtn.isSelected = true
         PetService.shared.parameters.breed.append(name + ",")
         print(PetService.shared.parameters.breed)
      } else {
         breedBtn.isSelected = false
         if let range = PetService.shared.parameters.breed.range(of: name + ",") {
            PetService.shared.parameters.breed.removeSubrange(range)
         }
      }
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      breedBtn.setImage(UIImage(named: "checkButtonOFF"), for: .normal)
      breedBtn.setImage(UIImage(named: "checkButtonON"), for: .selected)
   }
}

