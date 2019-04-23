//
//  ChoiceViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 08/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {
   
   @IBOutlet weak var catButton: UIButton!
   @IBOutlet weak var dogButton: UIButton!
   
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
      PetService.shared.checkToken()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      UIView.animate(withDuration: 0.5) {
         self.dogButton.isHidden = false
         self.catButton.isHidden = false
         
         self.cornersOpposite(image: self.dogButton)
         self.cornersOpposite(image: self.catButton)
      }
   }
   // Changing PetSearchVC for cat or dog
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowDogSearch" {
         let VC2 : PetSearchViewController = segue.destination as! PetSearchViewController
         VC2.pet = .dog
      } else if segue.identifier == "ShowCatSearch" {
         let VC2 : PetSearchViewController = segue.destination as! PetSearchViewController
         VC2.pet = .cat
      }
   }
}

