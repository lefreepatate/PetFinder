//
//  MainTabBarController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 06/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setuptTabBar()
      tabBar.barTintColor = .black
   }
   
   func setuptTabBar() {
      self.delegate = self
      let dogVC = tabBarController(title: "Dog search", selected: "checkButtonON",
                                   unSelected: "checkButtonOFF")
      let catVC = tabBarController(title: "Cat search", selected: "checkButtonON",
                                   unSelected: "checkButtonOFF")
      viewControllers = [dogVC, catVC]
   }
}

extension MainTabBarController {
   func tabBarController(title: String, selected: String, unSelected: String) -> UIViewController {
      let storyBoard = UIStoryboard(name:"Main" , bundle: nil)
      let viewController = storyBoard.instantiateViewController(withIdentifier: "PetSearchVC")
         as! PetSearchViewController
      viewController.tabBarItem = UITabBarItem(title: title, image: UIImage(named: unSelected)!,
                                               selectedImage: UIImage(named: selected)!)
      return viewController
   }
}
