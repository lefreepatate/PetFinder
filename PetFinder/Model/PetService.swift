//
//  PetService.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 26/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class PetService {
   init(){}
   private var task: URLSessionDataTask?
   // MARK: -- FAKE DATATASK FOR TESTING
   private var session = URLSession.shared
   init(session: URLSession) {
      self.session = session
   }
   // Parameters from pet's options to call
   static var parameters = Parameters()
   var token = TokenService()
   // PetFinder API CALL
   func getPets(_ callback: @escaping (Bool, Any?) -> Void) {
      let request = createRequest(with: PetService.parameters.code)
      task = session.dataTask(with: request){ (data, response, error) in
         DispatchQueue.main.async {
            guard let response = response as? HTTPURLResponse else { return callback(false, nil) }
            if response.statusCode == 401 {
               self.checkToken()
               callback(false, nil)
            } else {
               guard let data = data, error == nil else { return callback(false, nil) }
               do {
                  let decoder = JSONDecoder()
                  decoder.keyDecodingStrategy = .convertFromSnakeCase
                  if !request.description.contains(PetService.parameters.id) {
                     let response = try decoder.decode(Pets.self, from: data)
                     callback(true, response.animals)
                  } else if request.description.contains(PetService.parameters.id) {
                     let response = try decoder.decode(Pets.self, from: data)
                     callback(true, response.animal)
                  }
               } catch { return callback(false, nil) }
            }
         }
      }
      task?.resume()
   }
   // Token request for pet's results
   func createRequest(with token: String) -> URLRequest {
      let headers = [
         "Content-Type": "application/json",
         "Authorization": "Bearer \(token)",
         "cache-control": "no-cache"
      ]
      
      let urlString = "https://api.petfinder.com/v2/animals" + valuesString()
      var request = URLRequest(url: URL(string: urlString)!,
                               cachePolicy: .useProtocolCachePolicy,
                               timeoutInterval: 10.0)
      request.httpMethod = "GET"
      request.allHTTPHeaderFields = headers
      return request
   }
   // Getting the values for the api's search
   func valuesString() -> String {
      var values = String()
      for element in [PetService.parameters] {
         if !element.age.isEmpty{ values += "&age=" + element.age }
         if !element.breed.isEmpty{ values += "&breed=" + element.breed }
         if !element.color.isEmpty{
            if element.color.contains("Tricolor+%28Brown%2C+Black%2C+%26+White%29") {
               values += "&color[]=Tricolor+%28Brown%2C+Black%2C+%26+White%29"
            } else { values += "&color=" + element.color }
         }
         if !element.environnement.isEmpty{ values += "&environnement=" + element.environnement }
         if !element.gender.isEmpty {
            if element.gender.contains("any") { return "" } else { values += "&gender=" + element.gender }
         }
         if !element.size.isEmpty{ values += "&size=" + element.size }
         if !element.location.isEmpty{ values += "&location=" + element.location }
         if !element.distance.isEmpty{ values += "&distance=" + element.distance }
         if !element.id.isEmpty{
            values.removeAll()
            values += "/" + element.id }
      }
      let stringParameters = PetService.parameters.type + values.replacingOccurrences(of: ",&", with: "&")
      return  stringParameters + "&status=adoptable"
   }
   // Check if token is valid
   func checkToken() {
      let request = createRequest(with: PetService.parameters.code)
      task = session.dataTask(with: request){ (data, response, error) in
         DispatchQueue.main.async {
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 401 {
               TokenService.getToken { (success, token) in
                  if success, let token = token {
                     PetService.parameters.code = token
                  }
               }
            } else {
               return
            }
         }
      }
      task?.resume()
   }
}
