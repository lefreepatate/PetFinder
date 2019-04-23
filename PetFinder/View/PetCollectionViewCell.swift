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
   @IBOutlet weak var imageLoading: UIActivityIndicatorView!
   @IBOutlet weak var background: UIView!
   @IBOutlet weak var petImage: UIImageView!
   @IBOutlet weak var petName: UILabel!
   @IBOutlet weak var breedLabel: UILabel!
   @IBOutlet weak var genderLabel: UILabel!
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   func setGradientBackground() {
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [ #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor,#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor]
      gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
      gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.6)
      gradientLayer.locations = [0, 1]
      gradientLayer.frame = bounds
     
      petImage.layer.insertSublayer(gradientLayer, at: 0)
   }
   func petImageLoader(shown: Bool) {
      petImage.isHidden = shown
      imageLoading.isHidden = !shown
   }
}

