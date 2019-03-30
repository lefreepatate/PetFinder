//
//  DogsCollectionViewCell.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 28/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import Foundation

class DogsCollectionViewCell: UICollectionViewCell {
   @IBOutlet weak var petImage: UIImageView!
   @IBOutlet weak var petName: UILabel!
   @IBOutlet weak var breedLabel: UILabel!
   @IBOutlet weak var ageLabel: UILabel!
   @IBOutlet weak var genderLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
}
