//
//  DogViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 25/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class PetSearchViewController: UIViewController {
   // MARK: IBOUTLETS
   // MARK: -- LOCATION
   @IBOutlet weak var location: UITextField!
   @IBOutlet weak var milesDistance: UITextField!
   
   // MARK: -- COLORS OUTLETS
   @IBOutlet weak var colorsView: UIView!
   @IBOutlet weak var showColors: UIButton!
   @IBOutlet weak var colorSearchBar: UISearchBar!
   @IBOutlet weak var colorTableView: UITableView!
   
   // MARK: -- BREEDS OUTLETS
   @IBOutlet weak var breedView: UIView!
   @IBOutlet weak var showBreeds: UIButton!
   @IBOutlet weak var breedSearchBar: UISearchBar!
   @IBOutlet weak var breedTableView: UITableView!
   
   // MARK: OPTIONS BUTTONS
   @IBOutlet var ageBtns: [UIButton]!
   @IBOutlet var sizeBtns: [UIButton]!
   @IBOutlet var envBtns: [UIButton]!
   @IBOutlet weak var gender: UISegmentedControl!
   
   // MARK: LAUNCH SEARCH BUTTON
   @IBOutlet weak var showPets: UIButton!
   
   // OTHERS
   @IBOutlet weak var searchSV: UIScrollView!
   @IBOutlet weak var petimage: UIImageView!
   
   // MARK: IBACTIONS
   // MARK: BREED TABLEVIEW
   @IBAction func breedList(_ sender: UIButton) {
      viewOptions(view: breedView, button: sender)
   }
   // COLOR TABLEVIEW
   @IBAction func colorList(_ sender: UIButton) {
      viewOptions(view: colorsView, button: sender)
   }
   
   // MARK: BUTTONS ARRAY'S OPTIONS
   @IBAction func ageTappedBtn(_ sender: UIButton) {
      options(on: sender, buttons: ageBtns, parameters: &PetService.parameters.age)
   }
   @IBAction func sizeTappedBtn(_ sender: UIButton) {
      options(on: sender, buttons: sizeBtns, parameters: &PetService.parameters.size)
   }
   @IBAction func environnementTappedBtn(_ sender: UIButton) {
      options(on: sender, buttons: envBtns,parameters: &PetService.parameters.environnement)
   }
   
   // GENDER OPTIONS
   @IBAction func genderTappedBtn(_ sender: UISegmentedControl) {
      PetService.parameters.gender.removeAll()
      guard let text = gender.titleForSegment(at: sender.selectedSegmentIndex) else { return }
      PetService.parameters.gender.append(text.lowercased())
   }
   // Enum for change datas in searchPage
   enum Pet {
      case dog
      case cat
   }
   // VARIABLE TO CHOSSE TYPE OF PET
   var pet: Pet = .dog
   override func viewDidLoad() {
      super.viewDidLoad()
      getdesign()
   }
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      milesDistance.isHidden = true
      PetService.parameters.id.removeAll()
      PetService.parameters.type.removeAll()
      if pet == .dog {
         setAsDogSearch()
      } else if pet == .cat {
         setAsCatSearch()
      }
   }
   // INITIALIZING COLOR AND BREED ARRAYS
   var currentBreedArray = BreedLists.dogBreed
   var currentColorsArray = ColorsList.dogColors
   // MARK: OPTIONS
   // SETTING OPTIONS FOR DOG SEARCH
   func setAsDogSearch() {
      navigationItem.title = "Dog Search"
      petimage.image = UIImage(named: "dogSearch")
      currentBreedArray = BreedLists.dogBreed
      currentColorsArray = ColorsList.dogColors
      PetService.parameters.type.append("?type=dog")
   }
   // SETTING OPTIONS FOR CAT SEARCH
   func setAsCatSearch(){
      navigationItem.title = "Cat Search"
      petimage.image = UIImage(named: "catSearch")!
      currentBreedArray = BreedLists.catBreed
      currentColorsArray = ColorsList.catColors
      PetService.parameters.type.append("?type=cat")
   }
   // SHOWING/HIDDING TABLEVIEWS FOR COLORS AND BREEDS
   func viewOptions(view: UIView, button: UIButton) {
      if !button.isSelected {
         UIView.animate(withDuration: 0.3) {
            button.isSelected = true
            button.backgroundColor = .white
            button.setTitleColor(UIColor(cgColor: .red), for: .selected)
            self.showHiddenView(to: view, toogle: true)
         }
      } else if button.isSelected {
         UIView.animate(withDuration: 0.3) {
            button.isSelected = false
            button.backgroundColor = UIColor(cgColor: .red)
            button.setTitleColor(.white, for: .normal)
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
   // CHOOSING OPTIONS ON ARRAY AND BUTTONS STATEMENTS
   func options(on button: UIButton, buttons: [UIButton]!, parameters: inout String) {
      guard let value = button.titleLabel?.text as String? else { return }
      if button.tag == 1 {
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
   // MARK: SAVING VALUES ON MODEL PARAMETERS
   func saveValues(sender: UIButton, value: String, parameters: inout String){
      if !sender.isSelected {
         UIView.animate(withDuration: 0.3) {
            sender.isSelected = true
            sender.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.5568627451, blue: 0.7921568627, alpha: 1)
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
   // RESET BUTTONS TO 'UNSELECTED' IF ANY IS SELECTED
   func resetButtons(sender: UIButton, buttons: [UIButton]) {
      UIView.animate(withDuration: 0.3) {
         sender.isSelected = true
         sender.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.5568627451, blue: 0.7921568627, alpha: 1)
         for button in buttons where button.tag != 1 {
            button.isSelected = false
            button.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1647058824, blue: 0.1647058824, alpha: 1)
         }
      }
   }
}
// MARK: EXTENSION FOR TABLEVIEW
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
      // Returns data depending on wich tableView is selected
      if tableView == breedTableView {
         guard let breedCell = tableView.dequeueReusableCell(
            withIdentifier: "breedName", for: indexPath)
            as? BreedsTableViewCell else { return UITableViewCell() }
         breedCell.breedBtn.setTitle(self.currentBreedArray[indexPath.row], for: .normal)
         checkIfSelected(on: breedCell.breedBtn, parameter: PetService.parameters.breed)
         return breedCell
      } else if tableView == colorTableView {
         guard let colorCell = tableView.dequeueReusableCell(
            withIdentifier: "colorName", for: indexPath)
            as? ColorsTableViewCell else { return UITableViewCell() }
         let cellImage = currentColorsArray[indexPath.row].1
         colorCell.colorImage.image = cellImage
         colorCell.colorBtn.setTitle(self.currentColorsArray[indexPath.row].0, for: .normal)
         checkIfSelected(on: colorCell.colorBtn, parameter: PetService.parameters.color)
         return colorCell
      }
      return UITableViewCell()
   }
   // Function that guard selected state even if cell are reused
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
// MARK: EXTENSION FOR SEARCHBAR
extension PetSearchViewController: UISearchBarDelegate {
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      breedTypeTable(with: currentBreedArray, search: searchText)
      colorTypeTable(with: currentColorsArray, search: searchText)
      colorTableView.reloadData()
      breedTableView.reloadData()
   }
   // Returns breeds search
   func breedTypeTable(with breedArray: [String], search: String){
      guard !search.isEmpty else {
         emptyArray(on: breedTableView)
         return }
      currentBreedArray = breedArray.filter({ breed -> Bool in
         breed.contains(search)
      })
   }
   // Returns color search
   func colorTypeTable(with colorArray: [(String, UIImage)], search: String){
      guard !search.isEmpty else {
         emptyArray(on: colorTableView)
         return }
      currentColorsArray = colorArray.filter({ color -> Bool in
         color.0.contains(search)
      })
   }
   // Re-initialize arrays
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
// MARK: EXTENSION FOR LOCATION + DISTANCE TEXTFIELD SEARCH
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
         PetService.parameters.location.removeAll()
      }
      return true
   }
   @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
      breedSearchBar.resignFirstResponder()
      colorSearchBar.resignFirstResponder()
      location.resignFirstResponder()
      milesDistance.resignFirstResponder()
   }
   // MARK: SAVING LOCATION & DISTANCE IN PARAMETERS
   func setLocation() {
      guard let location = location.text else { return }
      PetService.parameters.location = location.replacingOccurrences(of: " ", with: "%20")
   }
   func setDistance() {
      guard let distance = milesDistance.text else { return }
      PetService.parameters.distance = distance
   }
}
// MARK: EXTENSION FOR DESIGN PROGRAMMATICALY
extension PetSearchViewController {
   func getdesign(){
      roundedButtons()
      setArrayButtons()
      setGradient(on: view)
      LocationDistancePresentation()
      cornersBottom(on: showPets)
      cornersTop(on: searchSV)
      gender.setTitleTextAttributes([.foregroundColor:UIColor.white], for: .normal)
      gender.setTitleTextAttributes([.foregroundColor:UIColor.white], for: .selected)
   }
   
   func LocationDistancePresentation() {
      milesDistance.attributedPlaceholder = NSAttributedString(string: "Miles", attributes:
         [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
      location.attributedPlaceholder = NSAttributedString(string: "Enter City, State or ZIP", attributes:
         [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
      milesDistance.borderStyle = .roundedRect
      milesDistance.layer.borderWidth = 2
      milesDistance.layer.cornerRadius = 8
      milesDistance.layer.borderColor = .red
      location.borderStyle = .roundedRect
      location.layer.borderWidth = 2
      location.layer.cornerRadius = 8
      location.layer.borderColor = .red
   }
   
   func roundedButtons() {
      setCornerRadiusToCircle(on: showBreeds)
      setCornerRadiusToCircle(on: showColors)
   }
   func setArrayButtons() {
      for buttons in [ageBtns, sizeBtns, envBtns] {
         for button in buttons! {
            setCornerRadius(on: button)
            button.layer.borderWidth = 2
            button.layer.borderColor = .blue
            button.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
            button.setTitleColor(.white, for: .selected)
         }
      }
   }
}
