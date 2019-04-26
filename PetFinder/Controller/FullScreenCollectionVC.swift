//
//  FullScreenCollectionVC.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 12/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class FullScreenCollectionVC: UICollectionViewController {
   @IBOutlet var imagesCollectionView: UICollectionView!
   var imageArray = [Photo]()
   private let reuseIdentifier = "fullScreen"
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      setGradient(on: view)
      let layout = imagesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
      let width = (view.frame.width)
      layout?.itemSize = CGSize(width: width, height: width)
   }
   func setImage(with url: URL, imageView: UIImageView) {
      URLSession.shared.dataTask(with: url) { (data, response, error) in
         if error != nil { return }
         guard let data = data else { return }
         DispatchQueue.main.async {
            imageView.image = UIImage(data: data)
         }
         }.resume()
   }
   override func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
   }
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return imageArray.count
   }
   // Getting image fullscreen on collectionViewcontroller
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FullScreenViewCell else { return UICollectionViewCell() }
      let image = imageArray[indexPath.row]
      let url = image.full
      let imageURL = URL(string: url!)
      cell.fullScreenImage.contentMode = .scaleAspectFill
      self.setImage(with: imageURL!, imageView: cell.fullScreenImage)
      let cellWidth = UIScreen.main.bounds.size
      cell.sizeThatFits(cellWidth)
      return cell
   }
}
