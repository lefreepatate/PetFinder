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
   @IBOutlet var favoritesCollection: UITableView!
   @IBOutlet weak var emptyLabel: UILabel!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   private let reuseIdentifier = "favoritePet"
   var favorites = FavoritePets.pets
   var pet:Animal!
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      favorites = FavoritePets.pets
      toggleActivityIndicator(shown: false)
      checkFavorites()
      favoritesCollection.reloadData()
      print(favorites.count)
   }
}

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
      cell.petGender?.text = favorite.gender
      cell.petDescription?.text = favorite.descr
      cell.petImage.image = UIImage(data: favorite.image!)
      cell.petImage.contentMode = .scaleAspectFill
      return cell
   }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let storyBoard = UIStoryboard(name: "Main", bundle: nil)
     guard let destinationVC = storyBoard.instantiateViewController(
      withIdentifier: "PetDetailViewController") as? PetDetailViewController else { return }
      destinationVC.id = favorites[indexPath.row].id!
      navigationController?.pushViewController(destinationVC, animated: true)
   }
   private func checkFavorites() {
      if favorites.isEmpty {
         emptyResponse()
      } else {
         toggleActivityIndicator(shown: false)
      }
   }
   
   private func emptyResponse() {
      self.emptyLabel.text = "Hey! You don't have any favorites yet.\n\nTo get favorites\npress the ★ button\non the top right corner\n;)"
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
      if editingStyle == .delete && favorites.count > 0 {
         AppDelegate.viewContext.delete(favorites.remove(at: indexPath.row))
         tableView.deleteRows(at: [indexPath], with: .middle)
      }
      if favorites.count == 0 {
         emptyResponse()
      }
      try? AppDelegate.viewContext.save()
   }
}
