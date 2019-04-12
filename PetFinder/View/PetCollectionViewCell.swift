//
//  DogsCollectionViewCell.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 28/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import Foundation

class PetCollectionViewCell: UICollectionViewCell {
   @IBOutlet weak var petImage: UIImageView!
   @IBOutlet weak var petName: UILabel!
   @IBOutlet weak var breedLabel: UILabel!
   @IBOutlet weak var ageLabel: UILabel!
   @IBOutlet weak var genderLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      getDesign()
      
   }
   func getDesign() {
      petImage.layer.borderWidth = 4
//      petImage.layer.borderColor = #colorLiteral(red: 1, green: 0.08064236111, blue: 0.1818865741, alpha: 1)
      petImage.layer.cornerRadius = 25
//      petImage.layer.maskedCorners =
//         [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
      petImage.clipsToBounds = true
   }
   func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
      gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
      gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
      gradientLayer.locations = [0, 1]
      gradientLayer.frame = bounds
     
      petImage.layer.insertSublayer(gradientLayer, at: 0)
   }
}

