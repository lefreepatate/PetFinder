//
//  DogViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 25/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class PetSearchViewController: UIViewController {
   
   @IBOutlet weak var location: UITextField!
   @IBOutlet var distance: [UIButton]!
   @IBOutlet weak var distanceBtn: UIButton!
   @IBOutlet weak var backGroundDistance: UIView!
   
   @IBOutlet weak var petimage: UIImageView!
   
   @IBOutlet weak var breedSearchBar: UISearchBar!
   @IBOutlet weak var breedTableView: UITableView!
   @IBOutlet weak var colorSearchBar: UISearchBar!
   @IBOutlet weak var colorTableView: UITableView!
   
   @IBOutlet var ageBtns: [UIButton]!
   @IBOutlet var sizeBtns: [UIButton]!
   @IBOutlet var envBtns: [UIButton]!
   @IBOutlet weak var gender: UISegmentedControl!
   @IBOutlet weak var showPets: UIButton!
   @IBAction func milesOptions(_ sender: UIButton) {
      showDistance(on: sender)
      //      if location.text?.isEmpty == false {
      //         distanceBtn.isEnabled = true
      //         distanceBtn.layer.opacity = 1
      //         showDistance(on: sender)
      //      }
   }
   @IBAction func distanceList(_ sender: UIButton) {
      guard let miles = sender.titleLabel?.text else { return }
      if !sender.isSelected && miles != "Anywhere" {
         sender.isSelected = true
         sender.backgroundColor = #colorLiteral(red: 0.1503180861, green: 1, blue: 0.4878128767, alpha: 1)
         for button in distance where button != sender {
            button.isSelected = false
            button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
         }
         PetService.shared.parameters.distance = miles + ","
      }  else if sender.isSelected && miles != "Anywhere" {
         sender.isSelected = false
         sender.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
         if let range = PetService.shared.parameters.distance.range(of: miles + ",") {
            PetService.shared.parameters.distance.removeSubrange(range)
         }
      }
      if miles == "Anywhere" {
         resetButtons(sender: sender, buttons: distance)
         PetService.shared.parameters.distance.removeAll()
      }
      print(PetService.shared.parameters.distance)
   }
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
   enum Pet {
      case dog
      case cat
   }
   var pet: Pet = .dog
   override func viewDidLoad() {
      super.viewDidLoad()
      removeAll()
      corners(image: petimage)
      if pet == .dog {
         setAsDogSearch()
      } else if pet == .cat {
         setAsCatSearch()
      }
   }
   var currentBreedArray = BreedLists.dogBreed
   var currentColorsArray = ColorsList.dogColors
   
   func setAsDogSearch() {
      navigationItem.title = "Dog Search"
      petimage.image = UIImage(named: "dogSearch")
      showPets.setTitle("Show dogs!", for: .normal)
      PetService.shared.parameters.type.append("?type=dog")
   }
   func setAsCatSearch(){
      navigationItem.title = "Cat Search"
      petimage.image = UIImage(named: "catSearch")!
      currentBreedArray = BreedLists.catBreed
      currentColorsArray = ColorsList.catColors
      showPets.setTitle("Show cats!", for: .normal)
      PetService.shared.parameters.type.append("?type=cat")
   }
   
   private func showDistance(on button: UIButton) {
      if !button.isSelected {
         button.isSelected = true
         UIView.animate(withDuration: 0.3) {
            self.backGroundDistance.isHidden = false
            for button in self.distance {
               button.isHidden = false
            }
         }
      } else {
         button.isSelected = false
         UIView.animate(withDuration: 0.3) {
            self.backGroundDistance.isHidden = true
            for button in self.distance {
               button.isHidden = true
            }
         }
      }
   }
   
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
      if !button.isSelected && button.tag == 1 {
         parameters.removeAll()
         resetButtons(sender: button, buttons: buttons)
      } else {
         for button in buttons where button.tag == 1 {
            button.isSelected = false
            button.backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
         }
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
      for button in buttons where button.tag != 1 {
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
      if pet == .dog {
         breedTypeTable(with: BreedLists.dogBreed, search: searchText)
         colorTypeTable(with: ColorsList.dogColors, search: searchText)
      } else if pet == .cat {
         breedTypeTable(with: BreedLists.catBreed, search: searchText)
         colorTypeTable(with: ColorsList.catColors, search: searchText)
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
