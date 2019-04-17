//
//  AnimationViewController.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 14/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController, URLSessionDownloadDelegate {
  
   
 let shapeLayer = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
     
      let center = view.center
      
      let trackLayer = CAShapeLayer()
      let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
      trackLayer.path = circularPath.cgPath
      trackLayer.strokeColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
      trackLayer.lineWidth = 10
      trackLayer.strokeEnd = 0
      trackLayer.fillColor = UIColor.clear.cgColor
      trackLayer.lineCap = CAShapeLayerLineCap.round
      view.layer.addSublayer(trackLayer)
      
      shapeLayer.path = circularPath.cgPath
      shapeLayer.strokeColor = #colorLiteral(red: 1, green: 0.08064236111, blue: 0.1818865741, alpha: 1)
      shapeLayer.lineWidth = 10
      shapeLayer.strokeEnd = 0
      shapeLayer.fillColor = UIColor.clear.cgColor
      shapeLayer.lineCap = CAShapeLayerLineCap.round
      view.layer.addSublayer(shapeLayer)
      view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
   
   public func downloadDatas(in function: ()){
      function
      let configuration = URLSessionConfiguration.default
      let operationQueue = OperationQueue()
      let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
      
      let downloadTask =  urlSession.downloadTask(with: URL(string: "")!)
      downloadTask.resume()
      print("downloading")
   }
   func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
      print("data loading")
   }
   fileprivate func animateCircle() {
      let basicAnim = CABasicAnimation(keyPath: "strokeEnd")
      basicAnim.toValue = 1
      basicAnim.duration = 2
      basicAnim.fillMode = CAMediaTimingFillMode.forwards
      basicAnim.isRemovedOnCompletion = false
      shapeLayer.add(basicAnim, forKey: "urSoBasic")
   }
   
   @objc func handleTap(){
      print("handleTap")
      downloadDatas(in: ())
      animateCircle()
   }
}
