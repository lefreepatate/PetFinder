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
      PetService.shared.checkToken()
      for button in btns {
         corners(image: button)
      }
   }
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

extension UIViewController {
   func corners(image: UIView) {
      image.layer.borderWidth = 10
      image.layer.borderColor = #colorLiteral(red: 1, green: 0.08064236111, blue: 0.1818865741, alpha: 1)
      image.layer.cornerRadius = 25
      image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
   }
   func presentAlert(with message: String) {
      let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
   }
}
