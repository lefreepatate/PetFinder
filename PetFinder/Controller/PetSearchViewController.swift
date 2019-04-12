//
//  DogViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 25/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class PetSearchViewController: UIViewController {
   
   @IBOutlet weak var petimage: UIImageView!
   // Breed options
   @IBOutlet weak var breedSearchBar: UISearchBar!
   @IBOutlet weak var breedTableView: UITableView!
   // Color options
   @IBOutlet weak var colorSearchBar: UISearchBar!
   @IBOutlet weak var colorTableView: UITableView!
   
   @IBOutlet var ageBtns: [UIButton]!
   @IBOutlet var sizeBtns: [UIButton]!
   @IBOutlet var envBtns: [UIButton]!
   @IBOutlet weak var gender: UISegmentedControl!
   @IBOutlet weak var showPets: UIButton!
   
   @IBAction func breedList(_ sender: UIButton) {
      tableOptions(tableview: breedTableView, searchBar: breedSearchBar, size: sizeBtns)
   }
   @IBAction func colorList(_ sender: UIButton) {
      tableOptions(tableview: colorTableView, searchBar: colorSearchBar, size: [UIButton()])
   }
   @IBAction func ageTappedBtn(_ sender: UIButton) {
      options(on: sender, buttons: ageBtns, parameters: &PetService.shared.parameters.age)
   }
   @IBAction func sizeTappedBtn(_ sender: UIButton) {
      options(on: sender, buttons: sizeBtns, parameters: &PetService.shared.parameters.size)
   }
   @IBAction func genderTappedBtn(_ sender: UISegmentedControl) {
      PetService.shared.parameters.gender.removeAll()
      guard let text = gender.titleForSegment(at: sender.selectedSegmentIndex) else { return }
      PetService.shared.parameters.gender.append(text.lowercased())
   }
   @IBAction func environnementTappedBtn(_ sender: UIButton) {
      options(on: sender, buttons: envBtns,parameters: &PetService.shared.parameters.environnement)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      corners(image: petimage)
      if buttonTag == 0 {
         dogValues()
      } else if buttonTag == 1 {
         catValues()
      }
   }
   var buttonTag = 0
   var catBreeds = BreedLists().catBreed
   var dogBreeds = BreedLists().dogBreed
   var currentBreedArray = BreedLists().dogBreed
   var dogColors = ColorsList().dogColors
   var catColors = ColorsList().catColors
   var currentColorsArray = ColorsList().dogColors
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      
      //      let customTabBar = (self.tabBarController as! MainTabBarController)
      
      //      PetService.shared.parameters.type.removeAll()
      //      if customTabBar.selectedIndex == 0 {
      //         customTabBar.navigationItem.title = "DOG SEARCH"
      //         dogValues()
      //      }  else if customTabBar.selectedIndex == 1 {
      //         customTabBar.navigationItem.title = "CAT SEARCH"
      //         catValues()
      //      }
   }
   //   override func viewWillAppear(_ animated: Bool) {
   //      super.viewWillAppear(animated)
   //      let customTabBar = (self.tabBarController as! MainTabBarController)
   //      self.navigationController?.navigationBar.prefersLargeTitles = true
   //   }
   func dogValues() {
      navigationItem.title = "Dog Search"
      petimage.image = UIImage(named: "dogSearch")
      showPets.setTitle("Show dogs!", for: .normal)
      PetService.shared.parameters.type.append("type=dog")
   }
   func catValues(){
      navigationItem.title = "Cat Search"
      petimage.image = UIImage(named: "catSearch")!
      currentBreedArray = catBreeds
      currentColorsArray = catColors
      showPets.setTitle("Show cats!", for: .normal)
      PetService.shared.parameters.type.append("type=cat")
   }
}

extension UIViewController {
   func tableOptions(tableview: UITableView, searchBar: UISearchBar, size: [UIButton]!) {
      if tableview.isHidden {
         showHideTable(to: tableview, searchBar: searchBar, toogle: true)
         size.forEach { (button) in
            button.isEnabled = false
            button.layer.opacity = 0.5
         }
      } else {
         showHideTable(to: tableview, searchBar: searchBar, toogle: false)
         size.forEach { (button) in
            button.isEnabled = true
            button.layer.opacity = 1
         }
      }
   }
   func showHideTable(to tableView: UITableView, searchBar: UISearchBar, toogle: Bool) {
      if toogle {
         UIView.animate(withDuration: 0.3) {
            tableView.isHidden = false
            searchBar.isHidden = false
         }
      } else {
         UIView.animate(withDuration: 0.3) {
            tableView.isHidden = true
            searchBar.isHidden = true
         }
      }
   }
   func options(on button: UIButton, buttons: [UIButton]!, parameters: inout String) {
      button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
      button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
      guard let value = button.titleLabel?.text as String? else { return }
      if !button.isSelected && value == "Any" {
         parameters.removeAll()
         resetButtons(sender: button, buttons: buttons)
      } else {
         saveValues(sender: button, value: value, parameters: &parameters)
      }
   }
   
   func saveValues(sender: UIButton, value: String, parameters: inout String){
      if !sender.isSelected {
         sender.isSelected = true
         sender.backgroundColor = #colorLiteral(red: 0.1503180861, green: 1, blue: 0.4878128767, alpha: 1)
         parameters.append(value.lowercased() + ",")
      }  else if sender.isSelected {
         sender.isSelected = false
         sender.backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
         if let range = parameters.range(of: value.lowercased() + ",") {
            parameters.removeSubrange(range)
         }
      }
   }
   
   func resetButtons(sender: UIButton, buttons: [UIButton]!) {
      sender.isSelected = true
      sender.backgroundColor = #colorLiteral(red: 0.1503180861, green: 1, blue: 0.4878128767, alpha: 1)
      for button in buttons where button.titleLabel!.text != "Any" {
         button.isSelected = false
         button.backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
      }
   }
   
   func removeAll() {
      PetService.shared.parameters.age.removeAll()
      PetService.shared.parameters.breed.removeAll()
      PetService.shared.parameters.color.removeAll()
      PetService.shared.parameters.environnement.removeAll()
      PetService.shared.parameters.gender.removeAll()
      PetService.shared.parameters.size.removeAll()
   }
}
extension UIViewController {
   func presentAlert(with message: String) {
      let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
   }
}

extension PetSearchViewController : UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if tableView == breedTableView {
      return currentBreedArray.count
      } else if tableView == colorTableView {
         return currentColorsArray.count
      }
      return 0
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if tableView == breedTableView {
         guard let breedCell = tableView.dequeueReusableCell(withIdentifier: "breedName", for: indexPath)
            as? BreedsTableViewCell else { return UITableViewCell() }
         breedCell.breedBtn.setTitle(self.currentBreedArray[indexPath.row], for: .normal)
         return breedCell
      } else if tableView == colorTableView {
         guard let colorCell = tableView.dequeueReusableCell(withIdentifier: "colorName", for: indexPath)
            as? ColorsTableViewCell else { return UITableViewCell() }
         colorCell.colorBtn.setTitle(self.currentColorsArray[indexPath.row].name, for: .normal)
         colorCell.colorBtn.setImage(self.currentColorsArray[indexPath.row].image, for: .normal)
         return colorCell
      }
      return UITableViewCell()
   }
}

extension PetSearchViewController: UISearchBarDelegate {
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      if buttonTag == 0 {
         breedTypeTable(with: dogBreeds, search: searchText)
         colorTypeTable(with: dogColors, search: searchText)
      } else if buttonTag == 1{
         breedTypeTable(with: catBreeds, search: searchText)
         colorTypeTable(with: catColors, search: searchText)
         //         guard !searchText.isEmpty else {
         //            currentBreedArray = catBreeds
         //            breedTableView.reloadData()
         //            return }
         //         currentBreedArray = catBreeds.filter({ breed -> Bool in
         //            breed.contains(searchText)
         //         })
      }
      breedTableView.reloadData()
   }
   
   func breedTypeTable(with breedArray: [String], search: String){
      guard !search.isEmpty else {
         currentBreedArray = breedArray
         breedTableView.reloadData()
         return }
      currentBreedArray = breedArray.filter({ breed -> Bool in
         breed.contains(search)
      })
   }
   func colorTypeTable(with colorArray: [(String, UIImage)], search: String){
      guard !search.isEmpty else {
         currentColorsArray = colorArray
         colorTableView.reloadData()
         return }
      currentColorsArray = colorArray.filter({ color -> Bool in
         color.0.contains(search)
      })
   }
}
