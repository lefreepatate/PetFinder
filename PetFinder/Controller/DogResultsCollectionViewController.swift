//
//  DogResultsCollectionViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 28/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class DogResultsCollectionViewController: UICollectionViewController {
   
   @IBOutlet var dogsCollectionView: UICollectionView!
   var animals = [Animal]()
   let reuseIdentifier = "DogsResults"
   var petImage = UIImage()
   override func viewDidLoad() {
      super.viewDidLoad()
      setDogsResults()
   }
   func setDogsResults() {
      PetService.shared.getPets(with: "") { (success, response) in
         if success, let response = response {
            self.animals = response
            self.dogsCollectionView.reloadData()
         } else {
            print("error occurred")
         }
      }
   }
   // MARK: UICollectionViewDataSource
   override func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
   }
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of items
      return animals.count
   }
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
      -> UICollectionViewCell {
         guard let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "DogsResults", for: indexPath)
               as? DogsCollectionViewCell else { return UICollectionViewCell() }
         let pet = animals[indexPath.row]
         cell.ageLabel.text = pet.age
         cell.petName.text = pet.name?.capitalized
         cell.breedLabel.text = self.getBreedString(with: pet.breeds!)
         cell.genderLabel.text = pet.gender
         guard let urlImage = pet.photos?[0].medium else { return cell}
         cell.petImage.loadImageFromURL(stringUrl:urlImage)
         return cell
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
         withIdentifier: "DogDetailViewController") as? DogDetailViewController else { return }
      let pet = animals[indexPath.row]
      destinationVC.petDetail = pet
      destinationVC.petBreed = self.getBreedString(with: pet.breeds!)
      navigationController?.pushViewController(destinationVC, animated: true)
   }
}
extension UIImageView {
   func loadImageFromURL(stringUrl: String){
      let url = URL(string: stringUrl)
      image = nil
      URLSession.shared.dataTask(with: url!) { (data, response, error) in
         if error != nil {
            return
         }
         DispatchQueue.main.async {
            self.image = UIImage(data: data!)
         }
         }.resume()
   }
}
