//
//  ChoiceViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 08/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {
   // MARK: IBOUTLET
   @IBOutlet weak var catButton: UIButton!
   @IBOutlet weak var dogButton: UIButton!
   // MARK: IBACTIONS
   @IBAction func dogsVC(_ sender: UIButton) {
      PetService.parameters.type.removeAll()
      self.performSegue(withIdentifier: "ShowDogSearch", sender: self)
   }
   @IBAction func catsVC(_ sender: UIButton) {
      PetService.parameters.type.removeAll()
      self.performSegue(withIdentifier: "ShowCatSearch", sender: self)
   }
   override func viewDidLoad() {
      super.viewDidLoad()
      PetService().checkToken()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      removeAll()
      UIView.animate(withDuration: 1) {
         self.dogButton.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.3).isActive = true
         self.catButton.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.3).isActive = true
         self.cornersOpposite(image: self.dogButton)
         self.cornersOpposite(image: self.catButton)
      }
   }
   // MARK: RESET PARAMETERS
   func removeAll() {
      PetService.parameters.id.removeAll()
      PetService.parameters.type.removeAll()
      PetService.parameters.age.removeAll()
      PetService.parameters.breed.removeAll()
      PetService.parameters.color.removeAll()
      PetService.parameters.environnement.removeAll()
      PetService.parameters.gender.removeAll()
      PetService.parameters.size.removeAll()
   }
   // Changing PetSearchVC for cat or dog's options
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

