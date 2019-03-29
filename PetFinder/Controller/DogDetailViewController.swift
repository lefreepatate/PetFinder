//
//  DogDetailViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 28/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class DogDetailViewController: UIViewController {
   
   
   @IBOutlet weak var dogImage: UIImageView!
   
   @IBOutlet weak var dogName: UILabel!
   @IBOutlet weak var breedLocalization: UILabel!
   @IBOutlet weak var ageGenderSizeColor: UILabel!
   @IBOutlet weak var hisStory: UILabel!
   @IBOutlet weak var coatLenght: UILabel!
   @IBOutlet weak var healthDescription: UILabel!
   @IBOutlet weak var goodAtHomeWith: UILabel!
   @IBOutlet weak var status: UILabel!
   @IBAction func linkTappedButton(_ sender: UIButton) {
      guard let stringURL = petDetail.url else { return }
      guard let url = URL(string: stringURL) else { return }
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
   }
   var petDetail:Animal!
   var petBreed = String()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setDatas()
   }
   
   func setDatas() {
      dogName.text = petDetail.name
      breedLocalization.text = petBreed
      ageGenderSizeColor.text = (petDetail.age! + " " + petDetail.size! + " ")
      hisStory.text = petDetail.description
      coatLenght.text = petDetail.coat
      goodAtHomeWith.text = petDetail.environment.debugDescription
      status.text = petDetail.status
   }
}
