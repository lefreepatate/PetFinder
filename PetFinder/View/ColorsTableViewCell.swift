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
   @IBOutlet var colorImage: UIImageView!
   @IBAction func colorAction(_ sender: UIButton) {
     saveColorOption()
   }
   
   func saveColorOption() {
      guard var name = colorBtn.titleLabel?.text else {return}
      name = name.replacingOccurrences(of: " ", with: "%20")
      if !colorBtn.isSelected {
         colorBtn.isSelected = true
         if name == "Tricolor%20(Brown,%20Black,%20&%20White)" {
            PetService.parameters.color.append("Tricolor+%28Brown%2C+Black%2C+%26+White%29" + ",")
         } else {
            PetService.parameters.color.append(name + ",")
         }
      } else {
         colorBtn.isSelected = false
         if let range = PetService.parameters.color.range(of: name + ",") {
            PetService.parameters.color.removeSubrange(range)
         }
      }
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      colorBtn.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1), for: .selected)
      colorImage.layer.cornerRadius = colorImage.frame.height/2
      colorImage.clipsToBounds = true
   }
}
