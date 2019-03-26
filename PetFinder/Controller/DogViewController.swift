//
//  DogViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 25/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class DogViewController: UIViewController {
   @IBAction func tokenbutton(_ sender: UIButton) {
      getToken()
   }
   
   func getToken() {
      PetService.shared.getPets { (success, response) in
         if success!, let response = response {
            print(response)
      }
   }
   }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
