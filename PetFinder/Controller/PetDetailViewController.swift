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
   
   
   @IBOutlet weak var status: UILabel!
   @IBOutlet weak var meetMeview: UIView!
   @IBOutlet weak var aboutView: UIView!
   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   @IBOutlet weak var imgCounter: UILabel!
   @IBOutlet weak var petImage: UIImageView!
   @IBOutlet weak var imageLoader: UIActivityIndicatorView!
   @IBOutlet weak var name: UILabel!
   @IBOutlet weak var breedGender: UILabel!
   @IBOutlet weak var ageSize: UILabel!
   @IBOutlet weak var hisStory: UILabel!
   @IBOutlet weak var healthTitle: UILabel!
   @IBOutlet weak var healthDescription: UILabel!
   @IBOutlet weak var environnementTitle: UILabel!
   @IBOutlet weak var goodAtHomeWith: UILabel!
   @IBOutlet weak var location: UILabel!
   @IBOutlet weak var mapButton: UIButton!
   @IBOutlet weak var buttonView: UIView!
   @IBOutlet weak var moreDetailsBtn: UIButton!
   @IBOutlet weak var favButton: UIButton!
   @IBAction func favoriteTappedButton(_ sender: UIButton) {
      if !sender.isSelected {
         saveFavorite()
      } else {
         deleteFavorite()
      }
   }
   @IBAction func mapButtonTapped(_ sender: UIButton) {
      guard let mapVC = storyboard?.instantiateViewController(withIdentifier: "Map")
         as? MapScreen else { return }
      mapVC.address = getAdressString(with: (petDetail.contact?.address)!)
      self.present(mapVC, animated: true, completion: nil)
   }
   @IBAction func linkTappedButton(_ sender: UIButton) {
      guard let stringURL = petDetail.url else { return }
      let url = URL(string: stringURL)
      UIApplication.shared.open(url!, options: [:], completionHandler: nil)
   }
   var petDetail:Animal!
   var petBreed = String()
   var id = String()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      toggleActivityIndicator(shown: true)
      getDesign()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      getPetDetails()
   }
   
   func getPetDetails() {
      PetService.shared.parameters.type.removeAll()
      PetService.shared.parameters.id = id
      PetService.shared.getPets { (success, response) in
         if success, let response = response as! Animal? {
            self.petDetail = response
            self.setDatas()
         } else {
            self.presentAlert(with: "Could not recive your pet's informations")
         }
      }
   }
   func setDatas() {
      displayImages()
      imgCounter.text = "PICS:\n\((petDetail.photos?.count ?? 0))"
      name.text = petDetail.name
      breedGender.text = petBreed
      ageSize.text =
      "Age: \(petDetail.age ?? "")\nGender: \(petDetail.gender ?? "")\nSize: \(petDetail.size ?? "")"
      if petDetail.coat != nil {
         ageSize.text?.append(contentsOf: "\nCoat: \(petDetail.coat ?? "")")
      }
      hisStory.text = petDetail.description
      goodAtHomeWith.text = self.getEnvironnementString(with: petDetail.environment!)
      location.text = self.getAdressString(with: (petDetail.contact?.address)!)
      healthDescription.text = self.getHealthString(with: petDetail.attributes!)
      status.text = petDetail.status
      checkFavoriteButtonState()
      toggleActivityIndicator(shown: false)
   }
   
   private func displayImages() {
      self.petImageLoader(shown: true)
      if petDetail.photos?.isEmpty == true {
         petImage.isUserInteractionEnabled = false
         petImage.image = UIImage(named: "dogSearch")
         imgCounter.isHidden = true
         self.petImageLoader(shown: false)
      } else {
         guard let url = petDetail.photos?[0].large else {return}
         if let imageURL = URL(string: url) {
            self.setImage(with: imageURL)
         }
         petImage.addGestureRecognizer(UITapGestureRecognizer(target:
            self, action: #selector(getImageFullScreen)))
         petImage.isUserInteractionEnabled = true
      }
   }
   
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
   
   @objc func saveFavorite() {
      let favorites = FavoritePets(context: AppDelegate.viewContext)
      favorites.name = name.text!
      favorites.age = ageSize.text!
      favorites.breed = petBreed
      favorites.id = String(petDetail.id!)
      favorites.descr = hisStory.text!
      if petImage.image != nil {
         favorites.image = petImage.image?.pngData()
      }
      favButton.isSelected = true
      favButtonState()
      try? AppDelegate.viewContext.save()
   }
   @objc private func deleteFavorite() {
      for favorite in FavoritePets.pets where (String(petDetail.id!) == favorite.id) {
         AppDelegate.viewContext.delete(favorite)
      }
      favButton.isSelected = false
      favButtonState()
      try? AppDelegate.viewContext.save()
   }
   func checkFavoriteButtonState() {
      favButton.isSelected = false
      for favorite in FavoritePets.pets where (favorite.id == String(petDetail.id!)) {
         favButton.isSelected = true
      }
       favButtonState()
   }
   func getEnvironnementString(with environnement: Environment) -> String {
      var envString = String()
      if environnement.children == true {
         envString += "◉ Childrens\n"
      }
      if environnement.dogs == true {
         envString += "◉ Dogs\n"
      }
      if environnement.cats == true {
         envString += "◉ Cats\n"
      } else if envString.isEmpty {
         envString = "Please ask the organization for more details"
      }
      return envString
   }
   
   func getHealthString(with attributes: Attributes) -> String {
      var healthString = String()
      if attributes.declawed == true {
         healthString += "◉ Declawed\n"
      }
      if attributes.houseTrained == true {
         healthString += "◉ House Trained\n"
      }
      if attributes.shotsCurrent == true {
         healthString += "◉ Shots Current\n"
      }
      if attributes.spayedNeutered == true {
         healthString += "◉ Spayed Neutered\n"
      }
      if attributes.specialNeeds == true {
         healthString += "◉ Special Needs\n"
      }
      else if healthString.isEmpty {
         healthString = "Please ask the organization for more details"
      }
      return healthString
   }
   
   func getAdressString(with adress: Address) -> String {
      var contact = String()
      if adress.address1?.description != nil {
         contact += (adress.address1 ?? "") + "," + (adress.address2 ?? "") + "\n"
      }
      contact += (adress.city ?? "") + "," + (adress.country ?? "")
      return contact
   }
   func toggleActivityIndicator(shown: Bool) {
      scrollView.isHidden = shown
      activityIndicator.isHidden = !shown
   }
   
   func petImageLoader(shown: Bool) {
      petImage.isHidden = shown
      imageLoader.isHidden = !shown
   }
   
   @objc func getImageFullScreen() {
      guard let fullScreenVC = storyboard?.instantiateViewController(withIdentifier: "FullScreenVC")
         as? FullScreenCollectionVC else { return }
      let petImages = petDetail
      fullScreenVC.imageArray = (petImages?.photos)!
      navigationController?.pushViewController(fullScreenVC, animated: true)
   }
}
extension PetDetailViewController {
   func getDesign() {
      setCornerRadiusToCircle(on: favButton)
      setGradientBackground(on: view)
      setCornerRadius(on: scrollView)
      setCornerRadiusToCircle(on: mapButton)
      cornersTop(image: meetMeview)
      cornersTop(image: aboutView)
      cornersTop(image: buttonView)
      cornersBottom(image: petImage)
      setCornerRadius(on: status)
      setCornerRadiusToCircle(on: imgCounter)
      setCornerRadiusToCircle(on: moreDetailsBtn)
   }
   
   func favButtonState() {
      let favoriteImage = UIImage(named: "favorites")
      let tintedImage = favoriteImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
      favButton.setImage(tintedImage, for: .normal)
      UIView.animate(withDuration: 0.3) {
         self.favButton.layer.opacity = 1
         if self.favButton.isSelected {
            self.favButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.favButton.tintColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
         } else if !self.favButton.isSelected {
            self.favButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3490196078, alpha: 1)
            self.favButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
         }
      }
   }
}
