//
//  DogViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 25/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class PetSearchViewController: UIViewController {
   
   @IBOutlet weak var searchSV: UIScrollView!
   @IBOutlet weak var location: UITextField!
   @IBOutlet weak var milesDistance: UITextField!
   
   @IBOutlet weak var petimage: UIImageView!
   @IBOutlet weak var breedView: UIView!
   
   @IBOutlet weak var breedSearchBar: UISearchBar!
   @IBOutlet weak var breedTableView: UITableView!
   @IBOutlet weak var colorsView: UIView!
   @IBOutlet weak var colorSearchBar: UISearchBar!
   @IBOutlet weak var colorTableView: UITableView!
   @IBOutlet var ageBtns: [UIButton]!
   @IBOutlet var sizeBtns: [UIButton]!
   @IBOutlet var envBtns: [UIButton]!
   @IBOutlet weak var gender: UISegmentedControl!
   @IBOutlet weak var showPets: UIButton!
   @IBOutlet weak var showColors: UIButton!
   @IBOutlet weak var showBreeds: UIButton!
   
   @IBAction func breedList(_ sender: UIButton) {
      viewOptions(view: breedView, button: sender)
   }
   @IBAction func colorList(_ sender: UIButton) {
      viewOptions(view: colorsView, button: sender)
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
      getdesign()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      removeAll()
      milesDistance.isHidden = true
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
      currentBreedArray = BreedLists.dogBreed
      currentColorsArray = ColorsList.dogColors
      PetService.shared.parameters.type.append("?type=dog")
   }
   func setAsCatSearch(){
      navigationItem.title = "Cat Search"
      petimage.image = UIImage(named: "catSearch")!
      currentBreedArray = BreedLists.catBreed
      currentColorsArray = ColorsList.catColors
      PetService.shared.parameters.type.append("?type=cat")
   }
   func viewOptions(view: UIView, button: UIButton) {
      UIView.animate(withDuration: 0.3) {
      if !button.isSelected {
         button.isSelected = true
         button.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1), for: .selected)
         button.setTitle("⇣", for: .selected)
         button.backgroundColor = .white
         self.showHiddenView(to: view, toogle: true)
      } else {
         button.isSelected = false
         button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
         button.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
         button.setTitle("+", for: .normal)
         self.showHiddenView(to: view, toogle: false)
      }
      }
   }
   func showHiddenView(to view: UIView, toogle: Bool) {
      if toogle {
         UIView.animate(withDuration: 0.3) {
            view.isHidden = false
         }
      } else {
         UIView.animate(withDuration: 0.3) {
            view.isHidden = true
         }
      }
   }
   func options(on button: UIButton, buttons: [UIButton]!, parameters: inout String) {
      guard let value = button.titleLabel?.text as String? else { return }
      if !button.isSelected && button.tag == 1 {
         parameters.removeAll()
         resetButtons(sender: button, buttons: buttons)
      } else {
         for button in buttons where button.tag == 1 {
            button.isSelected = false
            button.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1647058824, blue: 0.1647058824, alpha: 1)
         }
         saveValues(sender: button, value: value, parameters: &parameters)
      }
   }
   func saveValues(sender: UIButton, value: String, parameters: inout String){
      if !sender.isSelected {
         UIView.animate(withDuration: 0.3) {
            sender.isSelected = true
            sender.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
         }
         parameters.append(value.lowercased() + ",")
      }  else if sender.isSelected {
         UIView.animate(withDuration: 0.3) {
            sender.isSelected = false
            sender.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1647058824, blue: 0.1647058824, alpha: 1)
         }
         if let range = parameters.range(of: value.lowercased() + ",") {
            parameters.removeSubrange(range)
         }
      }
   }
   func resetButtons(sender: UIButton, buttons: [UIButton]!) {
      UIView.animate(withDuration: 0.3) {
         sender.isSelected = true
         sender.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
         for button in buttons where button.tag != 1 {
            button.isSelected = false
            button.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1647058824, blue: 0.1647058824, alpha: 1)
         }
      }
   }
   func removeAll() {
      PetService.shared.parameters.id.removeAll()
      PetService.shared.parameters.type.removeAll()
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
         guard let breedCell = tableView.dequeueReusableCell(
            withIdentifier: "breedName", for: indexPath)
            as? BreedsTableViewCell else { return UITableViewCell() }
         breedCell.breedBtn.setTitle(self.currentBreedArray[indexPath.row], for: .normal)
         checkIfSelected(on: breedCell.breedBtn, parameter: PetService.shared.parameters.breed)
         
         return breedCell
         
      } else if tableView == colorTableView {
         guard let colorCell = tableView.dequeueReusableCell(
            withIdentifier: "colorName", for: indexPath)
            as? ColorsTableViewCell else { return UITableViewCell() }
         let cellImage = currentColorsArray[indexPath.row].1
         colorCell.colorImage.image = cellImage
         colorCell.colorBtn.setTitle(self.currentColorsArray[indexPath.row].0, for: .normal)
         checkIfSelected(on: colorCell.colorBtn, parameter: PetService.shared.parameters.color)
         
         return colorCell
      }
      return UITableViewCell()
   }
   
   func checkIfSelected(on button: UIButton, parameter: String) {
      guard var name = button.titleLabel?.text else {return}
      name = name.replacingOccurrences(of: " ", with: "%20")
      if parameter.contains(name + ",") {
         button.isSelected = true
      } else {
         button.isSelected = false
      }
   }
}
extension PetSearchViewController: UISearchBarDelegate {
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      breedTypeTable(with: currentBreedArray, search: searchText)
      colorTypeTable(with: currentColorsArray, search: searchText)
      colorTableView.reloadData()
      breedTableView.reloadData()
   }
   
   func breedTypeTable(with breedArray: [String], search: String){
      guard !search.isEmpty else {
         emptyArray(on: breedTableView)
         return }
      currentBreedArray = breedArray.filter({ breed -> Bool in
         breed.contains(search)
      })
   }
   func colorTypeTable(with colorArray: [(String, UIImage)], search: String){
      guard !search.isEmpty else {
         emptyArray(on: colorTableView)
         return }
      currentColorsArray = colorArray.filter({ color -> Bool in
         color.0.contains(search)
      })
   }
   func emptyArray(on table: UITableView) {
      if pet == .dog {
         currentBreedArray = BreedLists.dogBreed
         currentColorsArray = ColorsList.dogColors
      } else if pet == .cat {
         currentBreedArray = BreedLists.catBreed
         currentColorsArray = ColorsList.catColors
      }
      table.reloadData()
   }
}
extension PetSearchViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      if location.text?.isEmpty == false {
         setLocation()
         UIView.animate(withDuration: 0.3) {
            self.milesDistance.isHidden = false
            self.setDistance()
         }
      } else {
         UIView.animate(withDuration: 0.3) {
            self.milesDistance.isHidden = true
         }
         PetService.shared.parameters.location.removeAll()
      }
      print(PetService.shared.parameters.location)
      return true
   }
   
   @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
      breedSearchBar.resignFirstResponder()
      colorSearchBar.resignFirstResponder()
      location.resignFirstResponder()
      milesDistance.resignFirstResponder()
   }
   
   func setLocation() {
      guard let location = location.text else { return }
      PetService.shared.parameters.location = location.replacingOccurrences(of: " ", with: "%20")
   }
   
   func setDistance() {
      guard let distance = Int(milesDistance.text!) else { return }
      PetService.shared.parameters.distance = distance
   }
}

extension PetSearchViewController {
   func getdesign(){
      self.showPets.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      self.showPets.layer.borderWidth = 5
      roundedButtons()
      setArrayButtons()
      setCornerRadius(on: searchSV)
      setGradientBackground(on: view)
      milesDistance.attributedPlaceholder = NSAttributedString(string: "Miles", attributes:  [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
      location.attributedPlaceholder = NSAttributedString(
         string: "Enter City, State or ZIP", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
      milesDistance.borderStyle = .roundedRect
      milesDistance.layer.borderWidth = 2
      milesDistance.layer.cornerRadius = 8
      milesDistance.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
      location.borderStyle = .roundedRect
      location.layer.borderWidth = 2
      location.layer.cornerRadius = 8
      location.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
   }
   func roundedButtons() {
      setCornerRadiusToCircle(on: showBreeds)
      setCornerRadiusToCircle(on: showColors)
      setCornerRadiusToCircle(on: showPets)
   }
   func setArrayButtons() {
      for buttons in [ageBtns, sizeBtns, envBtns] {
         for button in buttons! {
            setCornerRadius(on: button)
            button.layer.borderWidth = 2
            button.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
            button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
            button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
         }
      }
   }
}
