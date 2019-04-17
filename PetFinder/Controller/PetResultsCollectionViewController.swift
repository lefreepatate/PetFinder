//
//  DogResultsCollectionViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 28/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class PetsResultsCollectionViewController: UICollectionViewController {
   
   @IBOutlet weak var activityView: UIView!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   @IBOutlet var petsCollectionView: UICollectionView!
   var animals = [Animal]()
   var cacheImage = UIImage(named: "dogSearch")
   var parameters = Parameters()

   override func viewDidLoad() {
      super.viewDidLoad()
       petResultsSettings()
   }
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      let layout = petsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
      let width = (view.frame.width*0.48)
      layout?.itemSize = CGSize(width: width, height: width)
   }
   func petResultsSettings() {
      PetService.shared.getPets() { (success, response) in
         if success, let response = response as! [Animal]? {
            self.animals = response
            self.petsCollectionView.reloadData()
            self.toggleActivityIndicator(shown: false)
         } else {
            self.presentAlert(with: "An error with the network occured")
            self.toggleActivityIndicator(shown: false)
         }
      }
   }
   private func toggleActivityIndicator(shown: Bool) {
      petsCollectionView.isHidden = shown
      activityIndicator.isHidden = !shown
      activityView.isHidden = !shown
   }
   // MARK: UICollectionViewDataSource
   override func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
   }
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return animals.count
   }
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
      -> UICollectionViewCell {
         guard let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "PetsResults", for: indexPath)
               as? PetCollectionViewCell else { return UICollectionViewCell() }
         let pet = animals[indexPath.row]
         
         cell.ageLabel.text = pet.age
         cell.petName.text = pet.name?.capitalized
         cell.breedLabel.text = self.getBreedString(with: pet.breeds!)
         cell.genderLabel.text = pet.gender
         if pet.photos?.isEmpty == false {
            let image = pet.photos?[0].medium
            if let imageURL = URL(string: image!) {
            self.imageFrom(with: imageURL, cell: cell)
            }
         } else {
            cell.petImage.image = self.cacheImage
         }
         cell.setGradientBackground(colorTop:.clear, colorBottom: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8))
         return cell
   }
   
   func imageFrom(with stringURL: URL, cell: PetCollectionViewCell) {
      URLSession.shared.dataTask(with: stringURL) { (data, response, error) in
         if error != nil { return }
         guard let data = data else { return }
         DispatchQueue.main.async {
            cell.petImage.image = UIImage(data: data)
         }
      }.resume()
   }
   
   func getBreedString(with breed: Breeds) -> String {
      var breedString = String()
      if breed.primary != "" && breed.secondary != "" {
         breedString = (breed.primary ?? "") + " & " + (breed.secondary ?? "")
      } else if breed.primary != "" && breed.secondary == "" {
         breedString = (breed.primary ?? "")
      }
      if breed.mixed == true {
         breedString += " Mix"
      }
      return breedString.capitalized
   }
   // MARK: UICollectionViewDelegate
   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let storyBoard = UIStoryboard(name: "Main", bundle: nil)
      guard let destinationVC = storyBoard.instantiateViewController(
         withIdentifier: "PetDetailViewController") as? PetDetailViewController else { return }
      let pet = animals[indexPath.row]
      destinationVC.id = "\(pet.id!)"
      destinationVC.petBreed = self.getBreedString(with: pet.breeds!)
      navigationController?.pushViewController(destinationVC, animated: true)
   }
}

