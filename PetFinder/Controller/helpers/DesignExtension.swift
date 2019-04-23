//
//  DesignExtension.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 19/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
   func cornersOpposite(image: UIView) {
      image.layer.borderWidth = 5
      image.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
      image.layer.cornerRadius = 25
      image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
   }
   func cornersTop(image: UIView) {
      image.layer.cornerRadius = 50
      image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
   }
   func cornersBottom(image: UIView) {
      image.layer.cornerRadius = 50
      image.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner]
   }
   func setCornerRadiusToCircle(on image: UIView){
      image.layer.cornerRadius = image.frame.width/2
      image.clipsToBounds = true
   }
   func setCornerRadius(on image: UIView){
      image.layer.cornerRadius = 20
      image.clipsToBounds = true
   }
   func presentAlert(with message: String) {
      let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
   }
   
   func setGradientBackground(on view: UIView) -> Void {
      let gradientLayer = CAGradientLayer()
      gradientLayer.frame = view.bounds
      gradientLayer.locations = [0.0, 1.0]
      gradientLayer.colors = [#colorLiteral(red: 0.3647058824, green: 0, blue: 0.8666666667, alpha: 1).cgColor, #colorLiteral(red: 0.07843137255, green: 0.5568627451, blue: 0.7921568627, alpha: 1).cgColor]
      gradientLayer.startPoint = CGPoint(x: 0, y: 0)
      gradientLayer.endPoint = CGPoint(x: 1, y: 0)
      view.layer.insertSublayer(gradientLayer, at: 0)
   }
}

