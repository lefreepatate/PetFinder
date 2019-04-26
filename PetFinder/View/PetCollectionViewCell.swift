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
   
   func blackToTransparentGradient() -> CAGradientLayer {
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [#colorLiteral(red: 0.1725490196, green: 0.1647058824, blue: 0.1647058824, alpha: 0.7998983305).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor,]
      gradientLayer.startPoint = CGPoint(x: 0, y: 0.9)
      gradientLayer.endPoint = CGPoint(x: 0, y: 0.4)
      gradientLayer.frame = bounds
      return gradientLayer
   }
   func petImageLoader(shown: Bool) {
      petImage.isHidden = shown
      imageLoading.isHidden = !shown
   }
}

