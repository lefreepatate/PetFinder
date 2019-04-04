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
   var parameters = Parameters()
   override func viewDidLoad() {
      super.viewDidLoad()
      setDogsResults()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      let layout = dogsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
      if UIDevice.current.orientation.isPortrait {
         let width = (view.frame.width*0.48)
         layout?.itemSize = CGSize(width: width, height: width)
      } else if UIDevice.current.orientation.isLandscape {
         let width = (view.frame.width/3-10)
         layout?.itemSize = CGSize(width: width, height: width)
      }
   }

   func setDogsResults() {
      PetService.shared.getPets() { (success, response) in
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
         let imageURL = pet.photos
         cell.ageLabel.text = pet.age
         cell.petName.text = pet.name?.capitalized
         cell.breedLabel.text = self.getBreedString(with: pet.breeds!)
         cell.genderLabel.text = pet.gender
//         UIImageView().loadImageFromURL(stringUrl: (imageURL?[0].small)!) { (image) in
//            cell.petImage.image = image
//         }
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
   func loadImageFromURL(stringUrl: String, completion: @escaping (UIImage?) -> Void) {
      let url = URL(string: stringUrl)
      image = nil
      URLSession.shared.dataTask(with: url!) { (data, response, error) in
         if error != nil {
            completion(nil)
            return
         }
         DispatchQueue.main.async {
            self.image = UIImage(data: data!)
            completion(self.image)
         }
         }.resume()
   }
}
