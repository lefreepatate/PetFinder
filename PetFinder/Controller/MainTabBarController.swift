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
      //      let storyBoard = UIStoryboard(name:"Main" , bundle: nil)
      //      let viewController = storyBoard.instantiateViewController(withIdentifier: "ChoiceVC")
      //         as! ChoiceViewController
      dogVC.shouldPerformSegue(withIdentifier: "ShowDogSearch", sender: nil)
      catVC.shouldPerformSegue(withIdentifier: "ShowCatSearch", sender: nil)
      viewControllers = [dogVC, catVC]
   }
}

extension MainTabBarController {
   func tabBarController(title: String, selected: String, unSelected: String) -> UINavigationController {

      let navigationController = UINavigationController(rootViewController: PetSearchViewController())
      navigationController.tabBarItem = UITabBarItem(title: title, image: UIImage(named: unSelected)!,
                                                     selectedImage: UIImage(named: selected)!)
      return navigationController
   }
}
