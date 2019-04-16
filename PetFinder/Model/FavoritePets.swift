//
//  FavoritePets.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 12/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import CoreData

class FavoritePets: NSManagedObject {
   static var pets: [FavoritePets] {
      let request: NSFetchRequest<FavoritePets> = FavoritePets.fetchRequest()
      guard let favorites = try? AppDelegate.viewContext.fetch(request) else { return [] }
      return favorites
   }
}


