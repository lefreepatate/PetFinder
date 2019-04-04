//
//  CatSearchViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 03/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class CatSearchViewController: DogSearchViewController {
   
   @IBOutlet weak var catBreedSearchBar: UISearchBar!
   @IBOutlet weak var catBreedTableView: UITableView!
   @IBOutlet var catAge: [UIButton]!
   @IBOutlet var catSize: [UIButton]!
   @IBOutlet var catGoodWith: [UIButton]!
   @IBOutlet weak var catGender: UISegmentedControl!
   @IBOutlet weak var catBreed: UIButton!
   @IBAction override func breedList(_ sender: UIButton) {
      breedsOptions(tableview: catBreedTableView, searchBar: catBreedSearchBar, size: catSize)
   }
   @IBAction override func searchButton(_ sender: UIButton) {
      PetService.shared.parameters.type.removeAll()
      PetService.shared.parameters.type.append("type=cat")
   }
   override func sizeTappedButton(_ sender: UIButton) {
      options(on: sender, buttons: catSize,
              parameters: &PetService.shared.parameters.size)
   }
   override func ageTappedButton(_ sender: UIButton) {
      options(on: sender, buttons: catAge,
              parameters: &PetService.shared.parameters.age)
   }
   override func goodWithButton(_ sender: UIButton) {
      options(on: sender, buttons: catGoodWith, parameters: &PetService.shared.parameters.environnement)
   }
   override func viewDidLoad() {
      super.viewDidLoad()
      currentBreedArray = catBreeds
   }
   var catBreeds = BreedLists().catBreed
}

extension CatSearchViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return currentBreedArray.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "breedName", for: indexPath) as? BreedsTableViewCell else { return UITableViewCell() }
      //         cell.textLabel?.text = self.currentBreedArray[indexPath.row].capitalized
      cell.breedButtons.setTitle(self.currentBreedArray[indexPath.row], for: .normal)
      return cell
   }
}
