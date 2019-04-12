//
//  ImagesViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 10/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {
   
   @IBOutlet weak var mainScrollView: UIScrollView!
   var imageArray = [Photo]()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      populateArray()
   }
   
   func populateArray() {
      for petImg in 0..<self.imageArray.count {
         let imageView = UIImageView()
         guard let url = self.imageArray[petImg].full else {return}
         if let imageURL = URL(string: url) {
            self.setImage(with: imageURL, imageView: imageView)
            let xPosition = self.view.frame.width * CGFloat(petImg)
            imageView.frame = CGRect(x: xPosition, y: 0.5, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            self.mainScrollView.contentSize.width = self.mainScrollView.frame.width * CGFloat(petImg + 1)
            self.mainScrollView.addSubview(imageView)
         }
      }
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
   
}
