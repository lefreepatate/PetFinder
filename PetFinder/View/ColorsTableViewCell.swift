//
//  ColorsTableViewCell.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 11/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class ColorsTableViewCell: UITableViewCell {
   @IBOutlet var colorBtn: UIButton!
   @IBAction func colorAction(_ sender: UIButton) {
      guard let name = colorBtn.titleLabel?.text else {return}
      if !colorBtn.isSelected {
         colorBtn.isSelected = true
         if name != "Tricolor (Brown, Black, & White)" {
            PetService.shared.parameters.color.append(name + ",")
            print(PetService.shared.parameters.color)
         } else {
            PetService.shared.parameters.color.append("Tricolor+%28Brown%2C+Black%2C+%26+White%29" + ",")
            print(PetService.shared.parameters.color)
         }
         
      } else {
         colorBtn.isSelected = false
         if let range = PetService.shared.parameters.color.range(of: name + ",") {
            PetService.shared.parameters.color.removeSubrange(range)
         }
      }
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      colorBtn.imageView?.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
      colorBtn.imageView?.contentMode = .scaleAspectFit
      colorBtn.setImage(UIImage(), for: .normal)
   }
}
