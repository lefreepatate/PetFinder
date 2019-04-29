//
//  DogDetailViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 28/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import CoreData

class PetDetailViewController: UIViewController {
   // MARK: IBOUTLETS
   // MARK: -- LABELS
   @IBOutlet weak var statusLabel: UILabel!
   @IBOutlet weak var imgCounter: UILabel!
   @IBOutlet weak var name: UILabel!
   @IBOutlet weak var breedGender: UILabel!
   @IBOutlet weak var ageSize: UILabel!
   @IBOutlet weak var hisStory: UILabel!
   @IBOutlet weak var healthTitle: UILabel!
   @IBOutlet weak var healthDescription: UILabel!
   @IBOutlet weak var environnementTitle: UILabel!
   @IBOutlet weak var goodAtHomeWith: UILabel!
   @IBOutlet weak var location: UILabel!
   // MARK: -- VIEWS
   @IBOutlet weak var meetMeview: UIView!
   @IBOutlet weak var aboutView: UIView!
   // MARK: -- BUTTONS
   @IBOutlet weak var mapButton: UIButton!
   @IBOutlet weak var moreDetailsBtn: UIButton!
   @IBOutlet weak var favButton: UIButton!
   // MARK: -- OTHERS
   @IBOutlet weak var petImage: UIImageView!
   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   @IBOutlet weak var imageLoader: UIActivityIndicatorView!
   // MARK:  IBACTIONS
   @IBAction func favoriteTappedButton(_ sender: UIButton) {
      // Saving or deleting favorite pet
      favoriteButtonTapped()
   }
   // Getting mapView to see where the organization is
   @IBAction func mapButtonTapped(_ sender: UIButton) {
      guard let mapVC = storyboard?.instantiateViewController(withIdentifier: "Map")
         as? MapScreen else { return }
      mapVC.address = getAdressString(with: petDetail.contact?.address)
      self.present(mapVC, animated: true, completion: nil)
   }
   // Getting safari website for pet information
   @IBAction func linkTappedButton(_ sender: UIButton) {
      guard let stringURL = petDetail.url else { return }
      let url = URL(string: stringURL)
      UIApplication.shared.open(url!, options: [:], completionHandler: nil)
   }
   // MARK: VARIABLES FROM PET
   var petDetail:Animal!
   var petBreed = String()
   var id = String()
   override func viewDidLoad() {
      super.viewDidLoad()
      toggleActivityIndicator(shown: true)
      getDesign()
   }
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      getPetDetails()
   }
   // MARK: GETTING DATAS
   // API call for pet informations
   func getPetDetails() {
      PetService.parameters.type.removeAll()
      PetService.parameters.id = id
      PetService().getPets { (success, response) in
         if success, let response = response as! Animal? {
            self.petDetail = response
            self.setDatas()
         } else {
            self.presentAlert(with: "Could not recive your pet's informations")
         }
      }
   }
   // Displays informations on view's outlets
   func setDatas() {
      displayImages()
      getStatus()
      name.text = petDetail.name
      if petBreed != "" {
      breedGender.text = petBreed
      } else {
         breedGender.isHidden = true
      }
      ageSize.text =
      "Age: \(petDetail.age ?? "")\nGender: \(petDetail.gender ?? "")\nSize: \(petDetail.size ?? "")"
      if petDetail.coat != nil {
         ageSize.text?.append(contentsOf: "\nCoat: \(petDetail.coat ?? "")")
      }
      hisStory.text = petDetail.description
      goodAtHomeWith.text = self.getEnvironnementString(with: petDetail.environment)
      location.text = self.getAdressString(with: petDetail.contact?.address)
      healthDescription.text = self.getHealthString(with: petDetail.attributes)
      checkFavoriteButtonState()
      toggleActivityIndicator(shown: false)
   }
   // MARK: -- Transforms Boolean on String
   private func getEnvironnementString(with environnement: Environment?) -> String {
      var envString = String()
      if environnement?.children == true {
         envString += "◉ Childrens\n"
      }
      if environnement?.dogs == true {
         envString += "◉ Dogs\n"
      }
      if environnement?.cats == true {
         envString += "◉ Cats\n"
      } else if envString.isEmpty {
         envString = "Please ask the organization for more details"
      }
      return envString
   }
   private func getHealthString(with attributes: Attributes?) -> String {
      var healthString = String()
      if attributes?.declawed == true {
         healthString += "◉ Declawed\n"
      }
      if attributes?.houseTrained == true {
         healthString += "◉ House Trained\n"
      }
      if attributes?.shotsCurrent == true {
         healthString += "◉ Shots Current\n"
      }
      if attributes?.spayedNeutered == true {
         healthString += "◉ Spayed Neutered\n"
      }
      if attributes?.specialNeeds == true {
         healthString += "◉ Special Needs\n"
      }
      else if healthString.isEmpty {
         healthString = "Please ask the organization for more details"
      }
      return healthString
   }
   private func getAdressString(with adress: Address?) -> String {
      var contact = String()
      if adress?.address1?.description != nil {
         contact += (adress?.address1 ?? "") + ", " + (adress?.address2 ?? "") + "\n"
      }
      contact += (adress?.city ?? "") + ", " + (adress?.country ?? "")
      return contact
   }
   private func getStatus() {
      if petDetail.status == "adopted" {
         statusLabel.text = "Adopted"
         statusLabel.textColor = .white
         statusLabel.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
      } else if petDetail.status == "adoptable" {
         statusLabel.text = "Adoptable"
         statusLabel.textColor = #colorLiteral(red: 0.1725490196, green: 0.1647058824, blue: 0.1647058824, alpha: 1)
         statusLabel.backgroundColor = #colorLiteral(red: 0.1503180861, green: 1, blue: 0.4878128767, alpha: 1)
      }
   }
   // Check if pet have some pictures and displays if true
   private func displayImages() {
      self.petImageLoader(shown: true)
      if petDetail.photos?.isEmpty == true {
         petImage.isUserInteractionEnabled = false
         if petDetail.type == "Dog" {
            petImage.image = UIImage(named: "dogSearch")
         } else if petDetail.type == "Cat" {
            petImage.image = UIImage(named: "catSearch")
         }
         imgCounter.text = "No pics"
         self.petImageLoader(shown: false)
      } else {
         guard let url = petDetail.photos?[0].large else {return}
         if let imageURL = URL(string: url) {
            self.setImage(with: imageURL)
         }
         petImage.addGestureRecognizer(UITapGestureRecognizer(target:
            self, action: #selector(getImageFullScreen)))
         petImage.isUserInteractionEnabled = true
         imgCounter.text = "\((petDetail.photos?.count ?? 0)) pic(s)"
      }
   }
   // Getting pictures by URL
   private func setImage(with url: URL) {
      URLSession.shared.dataTask(with: url) { (data, response, error) in
         if error != nil { return }
         guard let data = data else { return }
         DispatchQueue.main.async {
            self.petImage.image = UIImage(data: data)
            self.petImageLoader(shown: false)
         }
         }.resume()
   }
   // SHOWING IMAGES ON FULLSCREEN VIEW
   @objc func getImageFullScreen() {
      guard let fullScreenVC = storyboard?.instantiateViewController(withIdentifier: "FullScreenVC")
         as? FullScreenCollectionVC else { return }
      fullScreenVC.imageArray = (petDetail.photos) ?? []
      navigationController?.pushViewController(fullScreenVC, animated: true)
   }
   // MARK: SAVE/DELETE FAVORITES
   // Favbutton saving or deleting favorites
   private func favoriteButtonTapped() {
      if !favButton.isSelected {
         favButton.isSelected = true
         saveFavorite()
         favButtonState()
      } else {
         favButton.isSelected = false
         deleteFavorite()
         favButtonState()
      }
   }
   @objc func saveFavorite() {
      let favorites = FavoritePets(context: AppDelegate.viewContext)
      favorites.name = name.text ?? "Name"
      favorites.age = ageSize.text ?? "Age"
      favorites.breed = petBreed
      favorites.id = String(petDetail.id ?? 0)
      favorites.descr = hisStory.text ?? "No Description"
      if petImage.image != nil {
         favorites.image = petImage.image?.pngData()
      }
      try? AppDelegate.viewContext.save()
   }
   @objc private func deleteFavorite() {
      for favorite in FavoritePets.pets where ((petDetail.id ?? 0) == Int(favorite.id ?? "0")) {
         AppDelegate.viewContext.delete(favorite)
      }
      try? AppDelegate.viewContext.save()
   }
   // Update favButton state on loading view
   func checkFavoriteButtonState() {
      favButton.isSelected = false
      for favorite in FavoritePets.pets where (Int(favorite.id ?? "0") == (petDetail.id ?? 0)) {
         favButton.isSelected = true
      }
      favButtonState()
   }
   // MARK: ACTIVITYS INDICATORS
   func toggleActivityIndicator(shown: Bool) {
      moreDetailsBtn.isHidden = shown
      scrollView.isHidden = shown
      activityIndicator.isHidden = !shown
   }
   func petImageLoader(shown: Bool) {
      petImage.isHidden = shown
      imageLoader.isHidden = !shown
      UIView.animate(withDuration: 0.3) {
         self.favButton.layer.opacity = 1
      }
   }
}
extension PetDetailViewController {
   // Some design changed programmaticaly
   func getDesign() {
      setCornerRadiusToCircle(on: favButton)
      setGradient(on: view)
      cornersTop(on: scrollView)
      setCornerRadiusToCircle(on: mapButton)
      cornersTop(on: meetMeview)
      setCornerRadius(on: aboutView)
      cornersTop(on: petImage)
      setCornerRadius(on: statusLabel)
      setCornerRadius(on: imgCounter)
      cornersBottom(on: moreDetailsBtn)
      setGradientButton(on: moreDetailsBtn)
   }
   // State of fabButton
   func favButtonState() {
      let favoriteImage = UIImage(named: "favoriteBtn")
      let tintedImage = favoriteImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
      favButton.setImage(tintedImage, for: .normal)
      UIView.animate(withDuration: 0.3) {
         if self.favButton.isSelected == true {
            self.favButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.favButton.tintColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
         } else if self.favButton.isSelected == false {
            self.favButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
            self.favButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
         }
      }
   }
}
