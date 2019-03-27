//
//  AlertProtocol.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 26/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import UIKit

protocol AlertProtocol {
   func presentAlert(with message: String)
}
extension UIViewController : AlertProtocol {
   func presentAlert(with message: String) {
      let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
   }
}
