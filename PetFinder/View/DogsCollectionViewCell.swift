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
   @IBOutlet weak var dogImage: UIImageView!
   @IBOutlet weak var dogName: UILabel!
   @IBOutlet weak var dogBreed: UILabel!
   @IBOutlet weak var dogAge: UILabel!
   @IBOutlet weak var dogGender: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
}
