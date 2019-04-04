//
//  PetService.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 26/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class PetService {
   static let shared = PetService()
   init(){}
   
   private var task: URLSessionDataTask?
   // MARK: -- FAKE DATATASK FOR TESTING
   private var session = URLSession.shared
   init(session: URLSession) {
      self.session = session
   }
   
   var parameters = Parameters()
   var token = TokenNumber()
   
   func getPets(_ callback: @escaping (Bool, [Animal]?) -> Void) {
      let request = createRequest(with: token.code)
      let session = URLSession.shared
      task?.cancel()
      task = session.dataTask(with: request){ (data, response, error) in
         DispatchQueue.main.async {
            guard let response = response as? HTTPURLResponse else { return callback(false, nil) }
            if response.statusCode == 401 {
               print(response.statusCode)
               self.token.newToken()
               self.task?.cancel()
            } else {
               guard let data = data, error == nil else { return callback(false, nil)}
               do {
                  let decoder = JSONDecoder()
                  decoder.keyDecodingStrategy = .convertFromSnakeCase
                  let response = try decoder.decode(Pets.self, from: data)
                  callback(true, response.animals)
               } catch { print("JSON ERROR") }
            }
         }
      }
      task?.resume()
   }
   
   private func createRequest(with token: String) -> URLRequest {
      let headers = [
         "Content-Type": "application/json",
         "Authorization": "Bearer \(token)",
         "cache-control": "no-cache"
      ]
      var request = URLRequest(url: URL(string: "https://api.petfinder.com/v2/animals?" + valuesString())!,
                                        cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
      request.httpMethod = "GET"
      request.allHTTPHeaderFields = headers
      print(request)
      return request
   }
   
   private func valuesString() -> String {
      var values = String()
      for element in [parameters] {
         if !element.age.isEmpty{ values += "&age=" + element.age }
         if !element.breed.isEmpty{ values += "&breed=" + element.breed  }
         if !element.color.isEmpty{ values += "&color[]=" + element.color}
         if !element.environnement.isEmpty{ values += "&environnement=" + element.environnement  }
         if !element.gender.isEmpty{ values += "&gender=" + element.gender  }
         if !element.size.isEmpty{ values += "&size=" + element.size  }
      }
      let stringParameters = parameters.type + values.replacingOccurrences(of: ",&", with: "&")
      return  stringParameters
   }
}
