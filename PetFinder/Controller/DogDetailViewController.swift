//
//  DogDetailViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 28/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class DogDetailViewController: UIViewController {
   
   @IBOutlet weak var petImage: UIImageView!
   @IBOutlet weak var petName: UILabel!
   @IBOutlet weak var breedLocalization: UILabel!
   @IBOutlet weak var ageGenderSizeColor: UILabel!
   @IBOutlet weak var hisStory: UILabel!
   @IBOutlet weak var coatLenght: UILabel!
   @IBOutlet weak var healthDescription: UILabel!
   @IBOutlet weak var goodAtHomeWith: UILabel!
   @IBOutlet weak var status: UILabel!
   @IBAction func linkTappedButton(_ sender: UIButton) {
      guard let stringURL = petDetail.url else { return }
      let url = URL(string: stringURL)
      UIApplication.shared.open(url!, options: [:], completionHandler: nil)
   }
   var petDetail:Animal!
   var petBreed = String()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setDatas()
      getDesign()
   }
   
   func setDatas() {
      let imageURL = petDetail.photos?[0].medium
      petImage?.loadImageFromURL(stringUrl:imageURL!)
      petName.text = petDetail.name
      breedLocalization.text = petBreed
      ageGenderSizeColor.text = ((petDetail.age ?? "") + " " + (petDetail.size ?? "") + " ")
      hisStory.text = petDetail.description
      hisStory.text?.append(contentsOf: self.getAdressString(with: (petDetail.contact?.address)!))
      coatLenght.text = petDetail.coat
      goodAtHomeWith.text = self.getEnvironnementString(with: petDetail.environment!)
      status.text = petDetail.status?.capitalized
      status.text?.append(contentsOf: " #" + ((petDetail.tags?.joined(separator: " #"))!))
   }
   
   func getEnvironnementString(with environnement: Environment) -> String {
      var envString = String()
      if environnement.children == true {
         envString += "Childrens" + " "
      }
      if environnement.dogs == true {
         envString += "Dogs" + " "
      }
      if environnement.cats == true {
         envString += "Cats"
      } else if envString.isEmpty {
         goodAtHomeWith.isHidden = true
      }
      return envString
   }
   
   func getAdressString(with adress: Address) -> String {
      var contact = String()
      if adress.address1?.description != nil {
         contact += "\n" + (adress.address1 ?? "") + "\n" + (adress.address2 ?? "")
      }
      contact += (adress.city ?? "") + " -- " + (adress.state ?? "")
      contact += (adress.postcode ?? "") + " -- " + (adress.country ?? "")
      return contact
   }
}
extension DogDetailViewController {
   func getDesign() {
      petImage.layer.cornerRadius = petImage.frame.height/2
      petImage.layer.borderWidth = 4
      petImage.layer.borderColor = #colorLiteral(red: 1, green: 0.3724520802, blue: 0.3093305528, alpha: 1)
      petImage.clipsToBounds = true
   }
}
