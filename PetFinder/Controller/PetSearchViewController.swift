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
   @IBOutlet weak var breedSearchBar: UISearchBar!
   @IBOutlet weak var breedTableView: UITableView!
   @IBOutlet var ageBtns: [UIButton]!
   @IBOutlet var sizeBtns: [UIButton]!
   @IBOutlet var envBtns: [UIButton]!
   @IBOutlet weak var gender: UISegmentedControl!
   @IBOutlet var breedDropDownBtn: UIButton!
   @IBOutlet weak var showPets: UIButton!
   @IBAction func breedList(_ sender: UIButton) {
      breedsOptions(tableview: breedTableView, searchBar: breedSearchBar, size: sizeBtns)
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
      print(PetService.shared.parameters.environnement)
   }
   @IBAction func searchButton(_ sender: UIButton) {
      PetService.shared.parameters.type.removeAll()
   }
   var tabBarcontroller: UITabBarController!
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   var catBreeds = BreedLists().catBreed
   var dogBreeds = BreedLists().dogBreed
   var currentBreedArray = BreedLists().dogBreed
   var colorsArray = ColorsList().dogColors
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      let dataModel = (self.tabBarController as! MainTabBarController)
      dataModel.navigationController?.navigationBar.prefersLargeTitles = true
      if dataModel.selectedIndex == 0 {
         dataModel.navigationItem.title = "Dog search"
         dogValues()
      }  else if dataModel.selectedIndex == 1 {
         dataModel.navigationItem.title = "Cat search"
         catValues()
      }
   }
   
   func dogValues() {
      currentBreedArray = dogBreeds
      petimage.image = UIImage(named: "dogSearch")
      showPets.setTitle("Show dogs!", for: .normal)
      PetService.shared.parameters.type.append("type=dog")
   }
   
   func catValues(){
      petimage.image = UIImage(named: "catSearch")!
      currentBreedArray = catBreeds
      showPets.setTitle("Show cats!", for: .normal)
      PetService.shared.parameters.type.append("type=cat")
   }
}
//if colorSelected == "Tricolor (Brown, Black, & White)" {
//   PetService.shared.parameters.color.append("Tricolor+%28Brown%2C+Black%2C+%26+White%29") // Soucis %26 -> %25%26
//} else {
//   PetService.shared.parameters.color.append(colorSelected.replacingOccurrences(of: " ", with: "%20"))
//}
extension UIViewController {
   func breedsOptions(tableview: UITableView, searchBar: UISearchBar, size: [UIButton]!) {
      if tableview.isHidden {
         getBreedTable(to: tableview, searchBar: searchBar, toogle: true)
         size.forEach { (button) in
            button.isEnabled = false
            button.layer.opacity = 0.5
         }
      } else {
         getBreedTable(to: tableview, searchBar: searchBar, toogle: false)
         size.forEach { (button) in
            button.isEnabled = true
            button.layer.opacity = 1
         }
      }
   }
   func getBreedTable(to tableView: UITableView, searchBar: UISearchBar, toogle: Bool) {
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
         sender.backgroundColor = #colorLiteral(red: 1, green: 0.3724520802, blue: 0.3093305528, alpha: 1)
         if let range = parameters.range(of: value + ",") {
            parameters.removeSubrange(range)
         }
      }
   }
   
   func resetButtons(sender: UIButton, buttons: [UIButton]!) {
      sender.isSelected = true
      sender.backgroundColor = #colorLiteral(red: 0.1503180861, green: 1, blue: 0.4878128767, alpha: 1)
      for button in buttons where button.titleLabel!.text != "Any" {
         button.isSelected = false
         button.backgroundColor = #colorLiteral(red: 1, green: 0.3724520802, blue: 0.3093305528, alpha: 1)
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
   
   private func deleteOption(on value: String, parameters: inout String) {
      if let range = parameters.range(of: value + ",") {
         parameters.removeSubrange(range)
      }
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
      return currentBreedArray.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "breedName", for: indexPath)
         as? BreedsTableViewCell else { return UITableViewCell() }
      cell.breedBtn.setTitle(self.currentBreedArray[indexPath.row], for: .normal)
      return cell
   }
}

extension PetSearchViewController: UISearchBarDelegate {
   
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      guard !searchText.isEmpty else {
         currentBreedArray = dogBreeds
         breedTableView.reloadData()
         return }
      currentBreedArray = dogBreeds.filter({ breed -> Bool in
         breed.contains(searchText)
      })
      breedTableView.reloadData()
   }
   
}
