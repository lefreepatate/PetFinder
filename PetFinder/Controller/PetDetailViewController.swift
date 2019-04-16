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
   
   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   @IBOutlet weak var imgCounter: UILabel!
   @IBOutlet weak var petImage: UIImageView!
   @IBOutlet weak var name: UILabel!
   @IBOutlet weak var breed: UILabel!
   @IBOutlet weak var ageGenderSizeColor: UILabel!
   @IBOutlet weak var hisStory: UILabel!
   @IBOutlet weak var coatLenght: UILabel!
   @IBOutlet weak var healthDescription: UILabel!
   @IBOutlet weak var goodAtHomeWith: UILabel!
   @IBOutlet weak var location: UILabel!
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
      getPetDetails()
      getDesign()
      corners(image: petImage)
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
      imgCounter.text = "\((petDetail.photos?.count ?? 0))"
      name.text = petDetail.name
      breed.text = petBreed
      ageGenderSizeColor.text = ((petDetail.age ?? "") + " " + (petDetail.size ?? "") + " ")
      hisStory.text = petDetail.description
      coatLenght.text = petDetail.coat
      goodAtHomeWith.text = self.getEnvironnementString(with: petDetail.environment!)
      location.text = self.getAdressString(with: (petDetail.contact?.address)!)
//      location.text = petDetail.status?.capitalized
//      location.text?.append(contentsOf: " #" + ((petDetail.tags?.joined(separator: " #"))!))
      favoriteButtonNavigationBar()
      toggleActivityIndicator(shown: false)
   }
   
   private func displayImages() {
      if petDetail.photos?.isEmpty == true {
         petImage.isUserInteractionEnabled = false
         petImage.image = UIImage(named: "dogSearch")
         imgCounter.isHidden = true
      } else {
         guard let url = petDetail.photos?[0].medium else {return}
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
         }
         }.resume()
   }
   
   @objc func saveFavorite() {
      let favorites = FavoritePets(context: AppDelegate.viewContext)
      favorites.name = name.text!
      favorites.age = petDetail.age!
      favorites.gender = petDetail.gender!
      favorites.breed = breed.text!
      favorites.id = String(petDetail.id!)
      favorites.descr = hisStory.text!
      if petImage.image != nil {
         favorites.image = petImage.image?.pngData()
      }
      navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      favoriteButtonNavigationBar()
      try? AppDelegate.viewContext.save()
   }
   @objc private func deleteFavorite() {
      for favorite in FavoritePets.pets where (String(petDetail.id!) == favorite.id) {
         AppDelegate.viewContext.delete(favorite)
      }
      favoriteButtonNavigationBar()
      try? AppDelegate.viewContext.save()
   }
   func favoriteButtonNavigationBar() {
      let barButtonSave =
         UIBarButtonItem(title: "★", style: .plain, target: self, action: #selector(saveFavorite))
      let barButtonDelete =
         UIBarButtonItem(title: "★", style: .plain, target: self, action: #selector(deleteFavorite))
      self.navigationItem.setRightBarButton(barButtonSave, animated: false)
      navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      for favorite in FavoritePets.pets where (favorite.id == String(petDetail.id!)) {
         self.navigationItem.setRightBarButton(barButtonDelete, animated: false)
         navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      }
   }
   func getEnvironnementString(with environnement: Environment) -> String {
      var envString = String()
      if environnement.children == true {
         envString += "Childrens" + " "
      }
      if environnement.dogs == true {
         envString += "Dogs" + " "
      }
      if environnement.cats == true {
         envString += "Cats"
      } else if envString.isEmpty {
         goodAtHomeWith.isHidden = true
      }
      return envString
   }
   func getAdressString(with adress: Address) -> String {
      var contact = String()
      if adress.address1?.description != nil {
         contact += "\n" + (adress.address1 ?? "") + "\n" + (adress.address2 ?? "")
      }
      contact += (adress.city ?? "") + " -- " + (adress.state ?? "")
      contact += (adress.postcode ?? "") + " -- " + (adress.country ?? "")
      return contact
   }
   func toggleActivityIndicator(shown: Bool) {
      activityIndicator.isHidden = !shown
      scrollView.isHidden = shown
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
      petImage.layer.cornerRadius = petImage.frame.height/2
      petImage.layer.borderWidth = 2
      petImage.layer.borderColor = #colorLiteral(red: 1, green: 0.3724520802, blue: 0.3093305528, alpha: 1)
      petImage.clipsToBounds = true
   }
}
