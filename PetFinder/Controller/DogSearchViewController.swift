//
//  DogViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 25/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class DogSearchViewController: UIViewController {
   
   @IBOutlet var ageButtons: [UIButton]!
   @IBOutlet var sizeButtons: [UIButton]!
   @IBAction func ageTappedButton(_ sender: UIButton) {
      options(on: sender)
   }
   @IBAction func sizeTappedButton(_ sender: UIButton) {
      options(on: sender)
   }
   @IBAction func tokenbutton(_ sender: UIButton) {
     
   }
   var parameters = String()
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
  
   
   func options(on button: UIButton){
      button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
      button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
      guard let name = button.titleLabel?.text else {return}
      if !button.isSelected {
         button.isSelected = true
         button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
         parameters += name + ","
      } else {
         button.isSelected = false
         button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
         parameters = parameters.replacingOccurrences(of: name + ",", with: "")
      }
      print(parameters)
   }
}
