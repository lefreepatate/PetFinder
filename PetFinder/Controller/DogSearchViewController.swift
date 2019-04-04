//
//  DogViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 25/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class DogSearchViewController: UIViewController, Options {
   
   @IBOutlet weak var dogBreedSearchBar: UISearchBar!
   @IBOutlet weak var dogBreedTableView: UITableView!
   @IBOutlet var dogAge: [UIButton]!
   @IBOutlet var dogSize: [UIButton]!
   @IBOutlet var dogGoodWith: [UIButton]!
   @IBOutlet weak var colorPickerView: UIPickerView!
   @IBOutlet weak var dogGender: UISegmentedControl!
   @IBOutlet var dogBreed: UIButton!
   @IBAction func breedList(_ sender: UIButton) {
      breedsOptions(tableview: dogBreedTableView, searchBar: dogBreedSearchBar, size: dogSize)
   }
   @IBAction func ageTappedButton(_ sender: UIButton) {
      options(on: sender, buttons: dogAge, parameters: &PetService.shared.parameters.age)
   }
   @IBAction func sizeTappedButton(_ sender: UIButton) {
      options(on: sender, buttons: dogSize, parameters: &PetService.shared.parameters.size)
   }
   @IBAction func genderTappedButton(_ sender: UISegmentedControl) {
      PetService.shared.parameters.gender.removeAll()
      guard let text = dogGender.titleForSegment(at: sender.selectedSegmentIndex) else { return }
      PetService.shared.parameters.gender.append(text.lowercased())
   }
   @IBAction func goodWithButton(_ sender: UIButton) {
      options(on: sender, buttons: dogGoodWith,parameters: &PetService.shared.parameters.environnement)
      print(PetService.shared.parameters.environnement)
   }
   @IBAction func searchButton(_ sender: UIButton) {
      PetService.shared.parameters.type.removeAll()
      PetService.shared.parameters.type.append("type=dog")
   }
   override func viewDidLoad() {
      super.viewDidLoad()
      currentBreedArray = dogBreeds
   }
   
   var dogBreeds = BreedLists().dogBreed
   var currentBreedArray = BreedLists().dogBreed
   var colorsArray = ColorsList().dogColors 
}

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
}

extension DogSearchViewController : UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return currentBreedArray.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "breedName", for: indexPath) as? BreedsTableViewCell else { return UITableViewCell() }
      //         cell.textLabel?.text = self.currentBreedArray[indexPath.row].capitalized
      cell.breedButtons.setTitle(self.currentBreedArray[indexPath.row], for: .normal)
      return cell
   }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      var values = String()
      let button = UIButton()
      guard let name = button.title(for: .normal) else { return }
      
      if !button.isSelected {
         button.isSelected = true
         values += name + ","
      } else {
         button.isSelected = false
         values = values.replacingOccurrences(of: name + ",", with: "")
      }
      print(values)
      self.dogBreedTableView.reloadData()
   }
}

extension DogSearchViewController: UISearchBarDelegate {
   
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      guard !searchText.isEmpty else {
         currentBreedArray = dogBreeds
         dogBreedTableView.reloadData()
         return }
      currentBreedArray = dogBreeds.filter({ breed -> Bool in
         breed.contains(searchText)
      })
      dogBreedTableView.reloadData()
   }
   
}

extension DogSearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return colorsArray.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return colorsArray[row]
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      PetService.shared.parameters.color.removeAll()
      let colorSelected = colorsArray[pickerView.selectedRow(inComponent: 0)]
      if colorSelected == "Tricolor (Brown, Black, & White)" {
         PetService.shared.parameters.color.append("Tricolor+%28Brown%2C+Black%2C+%26+White%29") // Soucis %26 -> %25%26
      } else {
         PetService.shared.parameters.color.append(colorSelected.replacingOccurrences(of: " ", with: "%20"))
      }
   }
   
   
}
