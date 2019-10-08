//
//  FavoritesCollectionVC.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 12/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController {
   // MARK: IBOUTLETS
   @IBOutlet var favoritesCollection: UITableView!
   @IBOutlet weak var emptyLabel: UILabel!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   // MARK: VARIABLES
   private let reuseIdentifier = "favoritePet"
   // Calling the favorites saved on coreData
   var favorites = FavoritePets.pets
   var pet:Animal!
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      // refreshing favorites
      favorites = FavoritePets.pets
      toggleActivityIndicator(shown: false)
      checkFavorites()
      favoritesCollection.reloadData()
      setGradient(on: view)
   }
}
// MARK: RETURNS CELLS FOR FAVORITES WITH CELLS IBOUTLETS
extension FavoritesVC: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return favorites.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
         as? FavoritesViewCell else { return UITableViewCell()}
      let favorite = favorites[indexPath.row]
      cell.petName?.text = favorite.name
      cell.petBreed?.text = favorite.breed
      cell.petAge?.text = favorite.age
      cell.petImage.image = UIImage(data: favorite.image!)
      cell.petImage.contentMode = .scaleAspectFill
      cornersOpposite(image: cell.petImage)
      return cell
   }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let storyBoard = UIStoryboard(name: "Main", bundle: nil)
     guard let destinationVC = storyBoard.instantiateViewController(
      withIdentifier: "PetDetailViewController") as? PetDetailViewController else { return }
      destinationVC.petBreed = favorites[indexPath.row].breed ?? ""
      destinationVC.id = favorites[indexPath.row].id ?? ""
      navigationController?.pushViewController(destinationVC, animated: true)
   }
   // If no favorites in view, user get info on how to get favorites
   private func checkFavorites() {
      if favorites.isEmpty {
         emptyResponse()
      } else {
         emptyLabel.isHidden = true
         toggleActivityIndicator(shown: false)
      }
   }
   // Info to get favorites
   private func emptyResponse() {
      emptyLabel.isHidden = false
      self.emptyLabel.text = "You don't have any favorites yet.\n\nTo get favorites\npress the favorite button\n"
      self.favoritesCollection.isHidden = true
      self.activityIndicator.isHidden = true
   }
   private func toggleActivityIndicator(shown: Bool) {
      favoritesCollection.isHidden = shown
      activityIndicator.isHidden = !shown
   }
}
extension FavoritesVC: UITableViewDelegate {
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                  forRowAt indexPath: IndexPath) {
      // Deleting cell + his data saved on coreData
      if editingStyle == .delete && favorites.count > 0 {
         AppDelegate.viewContext.delete(favorites.remove(at: indexPath.row))
         tableView.deleteRows(at: [indexPath], with: .middle)
      }
      // if last favorite deleted, then showing info to have more
      if favorites.count == 0 {
         emptyResponse()
      }
      // Saving changes on coreData
      try? AppDelegate.viewContext.save()
   }
}
