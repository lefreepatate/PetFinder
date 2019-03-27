//
//  DogViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 25/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class DogViewController: UIViewController {
   @IBOutlet weak var textfieldtest: UITextView!
   @IBAction func tokenbutton(_ sender: UIButton) {
      getToken()
   }
   var animals = [Animal]()
   override func viewDidLoad() {
      super.viewDidLoad()
      PetService.shared.checkValidToken()
   }
   func getToken() {
      PetService.shared.getPets { (success, response) in
         if success, let response = response {
            self.animals = response
         }
      }
   }
}
