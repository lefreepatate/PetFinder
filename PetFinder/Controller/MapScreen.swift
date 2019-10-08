//
//  MapScreen.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 14/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapScreen: UIViewController {
   // MARK: OUTLETS
   @IBOutlet weak var goBtn: UIButton!
   @IBOutlet weak var dissMissBtn: UIButton!
   @IBOutlet weak var mapView: MKMapView!
   // MARK: VARIABLES TO SET LOCATION
   let locationManager = CLLocationManager()
   let regionInMeters:Double = 10000
   var previousLocation: CLLocation?
   var address = String()
   // MARK: ACTION TO GET PLANS FOR GPS
   @IBAction func mapButton(_ sender: UIButton) {
     viewDirectionsOnMaps()
   }
   override func viewDidLoad() {
        super.viewDidLoad()
      // Check if options in settings are allowed
      checkLocationServices()
      startTackingUserLocation()
      getDesign()
      // Update route to the organization
      coordinates(forAddress: address) { (location) in
         guard let location = location else { return }
         self.getDirections(location: location)
      }
   }
   // Launch Maps to have drive directions
   private func viewDirectionsOnMaps() {
      coordinates(forAddress: address) { (destination) in
         guard let destination = destination else { return }
         let regionSpan = MKCoordinateRegion(center: destination, latitudinalMeters: destination.latitude, longitudinalMeters: destination.longitude)
         let placeMark = MKPlacemark(coordinate: destination, addressDictionary: nil)
         let mapItem = MKMapItem(placemark: placeMark)
         let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span) ]
         mapItem.name = "Organization"
         mapItem.openInMaps(launchOptions: options)
      }
   }
   // Look at coordinates from organization's address
   func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
      let geocoder = CLGeocoder()
      geocoder.geocodeAddressString(address) { (placemarks, error) in
         guard  error == nil else {
            completion(nil)
            return
         }
         let placemark = MKPlacemark(placemark: (placemarks?[0])!)
         let annotation = MKPointAnnotation()
         annotation.title = "Organization"
         annotation.subtitle = address
         annotation.coordinate = placemark.coordinate
         
         self.mapView.addAnnotation(annotation)
         completion(placemarks?.first?.location?.coordinate)
      }
   }
   func setupLocationManager() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
   }
   func centerViewOnUserLocation() {
      if let location = locationManager.location?.coordinate {
         
         let region = MKCoordinateRegion.init(center: location,
                                              latitudinalMeters: regionInMeters,
                                              longitudinalMeters: regionInMeters)
         
         mapView.setRegion(region, animated: true)
      }
   }
   func checkLocationServices() {
      if CLLocationManager.locationServicesEnabled() {
         setupLocationManager()
         checkLocationAuthorization()
      } else {
         presentAlert(with: "We could not be able to locate your position, please turn on Location Service")
      }
   }
   // MARK: CHECKING LOCATION AUTORIZATION AND ASING IF APP CAN ACCESS TO
   func checkLocationAuthorization() {
      switch CLLocationManager.authorizationStatus() {
      case .authorizedWhenInUse:
         startTackingUserLocation()
         break
      case .denied:
         presentAlert(with: "Your iPhone don't allow current position")
         break
      case .notDetermined:
         locationManager.requestWhenInUseAuthorization()
      case .restricted:
         break
      case .authorizedAlways:
         break
      @unknown default:
         fatalError()
      }
   }
   func startTackingUserLocation() {
      mapView.showsUserLocation = true
      centerViewOnUserLocation()
      locationManager.startUpdatingLocation()
      previousLocation = getCenterLocation(for: mapView)
   }
   func getCenterLocation(for mapView: MKMapView) -> CLLocation {
      let latitude = mapView.centerCoordinate.latitude
      let longitude = mapView.centerCoordinate.longitude
      return CLLocation(latitude: latitude, longitude: longitude)
   }
   // MARK: GETTING DIRECTIONS FROM ORGANIZATION ADDRESS
   func getDirections(location: CLLocationCoordinate2D) {
      let request = createDirectionRequest(from: location)
      let directions = MKDirections(request: request)
      directions.calculate { (response, error) in
         guard let response = response else { return }
         for route in response.routes {
            self.mapView.addOverlay(route.polyline)
            let rect = route.polyline.boundingMapRect
            let options = UIEdgeInsets.init(top: 50, left: 50, bottom: 50, right: 50)
            self.mapView.setVisibleMapRect(rect, edgePadding: options, animated: true)
            }
         }
      }
   func createDirectionRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
      let destinationLocation 	= getCenterLocation(for: mapView).coordinate
      let startingLocation 		= MKPlacemark(coordinate: coordinate)
      let destination 			= MKPlacemark(coordinate: destinationLocation)
      
      let request 				= MKDirections.Request()
      request.source 			= MKMapItem(placemark: startingLocation)
      request.destination      	= MKMapItem(placemark: destination)
      
      request.transportType 	= .automobile
      request.requestsAlternateRoutes = true
      
      return request
   }
   
   @IBAction func dissmissBtn(_ sender: Any) {
      dismiss(animated: true, completion: nil)
   }
}

extension MapScreen: CLLocationManagerDelegate {
   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      checkLocationAuthorization()
   }
}

extension MapScreen: MKMapViewDelegate {
   func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
      renderer.strokeColor = .green
      return renderer
   }
}

extension MapScreen {
   func getDesign() {
      cornersTop(on: mapView)
      cornersBottom(on: goBtn)
      dissMissBtn.layer.borderWidth = 3
      dissMissBtn.layer.borderColor = #colorLiteral(red: 0.1725490196, green: 0.1647058824, blue: 0.1647058824, alpha: 0.5)
      setCornerRadiusToCircle(on: dissMissBtn)
   }
}
