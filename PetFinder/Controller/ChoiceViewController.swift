//
//  ChoiceViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 08/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {

   @IBOutlet var btns: [UIButton]!
   @IBAction func dogsVC(_ sender: UIButton) {
      PetService.shared.parameters.type.removeAll()
      self.performSegue(withIdentifier: "ShowDogSearch", sender: self)
   }
   
   @IBAction func catsVC(_ sender: UIButton) {
      PetService.shared.parameters.type.removeAll()
      self.performSegue(withIdentifier: "ShowCatSearch", sender: self)
   }

   override func viewDidLoad() {
        super.viewDidLoad()
      for button in btns {
         corners(image: button)
      }
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowDogSearch" {
         let VC2 : PetSearchViewController = segue.destination as! PetSearchViewController
         VC2.buttonTag = 0
      } else if segue.identifier == "ShowCatSearch" {
         let VC2 : PetSearchViewController = segue.destination as! PetSearchViewController
         VC2.buttonTag = 1
      }
    }
}

extension UIViewController {
   func corners(image: UIView) {
         image.layer.borderWidth = 10
         image.layer.borderColor = #colorLiteral(red: 1, green: 0.08064236111, blue: 0.1818865741, alpha: 1)
         image.layer.cornerRadius = 25
         image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
   }
}
