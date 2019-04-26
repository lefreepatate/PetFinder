//
//  DesignExtension.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 19/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import UIKit
// SOME FUNCTIONS CALLED TO HAVE DESIGN CHANGES
extension UIViewController {
   func cornersOpposite(image: UIView) {
      image.layer.borderWidth = 5
      image.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
      image.layer.cornerRadius = 25
      image.backgroundColor = #colorLiteral(red: 0.1064236111, green: 0.09467592593, blue: 0.09769199351, alpha: 0.5)
      image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
      image.clipsToBounds = true
   }
   func cornersTop(on image: UIView) {
     image.layer.cornerRadius = 15
      image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
     image.clipsToBounds = true
   }
   func cornersBottom(on image: UIView) {
      image.layer.cornerRadius = 15
      image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
      image.clipsToBounds = true
   }
   func setCornerRadiusToCircle(on image: UIView){
      image.layer.cornerRadius = image.frame.height/2
      image.clipsToBounds = true
   }
   func setCornerRadius(on image: UIView){
      image.layer.cornerRadius = 15
      image.clipsToBounds = true
   }
   func presentAlert(with message: String) {
      let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
   }
   
   func setGradientButton(on view: UIView) -> Void {
      let gradientLayer = CAGradientLayer()
      gradientLayer.frame = self.view.bounds
      gradientLayer.locations = [0.0, 1.0]
      gradientLayer.colors = [#colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1).cgColor, #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor]
      gradientLayer.startPoint = CGPoint(x: 0, y: 0)
      gradientLayer.endPoint = CGPoint(x: 1, y: 1)
      view.layer.insertSublayer(gradientLayer, at: 0)
   }
   
   func setGradient(on view: UIView) -> Void {
      let gradientLayer = CAGradientLayer()
      gradientLayer.frame = view.bounds
      gradientLayer.locations = [0.0, 1.0]
      gradientLayer.colors = [#colorLiteral(red: 0.3647058824, green: 0, blue: 0.8666666667, alpha: 1).cgColor, #colorLiteral(red: 0.07843137255, green: 0.5568627451, blue: 0.7921568627, alpha: 1).cgColor]
      gradientLayer.startPoint = CGPoint(x: 0, y: 0)
      gradientLayer.endPoint = CGPoint(x: 1, y: 0)
      view.layer.insertSublayer(gradientLayer, at: 0)
   }
}

