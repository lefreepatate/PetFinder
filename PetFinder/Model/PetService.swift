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
   var token = TokenNumber()
   func getPets(with parameters: Any, _ callback: @escaping (Bool, [Animal]?) -> Void) {
      let request = createRequest(with: token.code, parameters: parameters)
      let session = URLSession.shared
      task?.cancel()
      task = session.dataTask(with: request){ (data, response, error) in
         DispatchQueue.main.async {
            
            guard let response = response as? HTTPURLResponse else { return callback(false, nil) }
            print(response.statusCode)
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
   
   func createRequest(with token: String, parameters: Any) -> URLRequest {
      let headers = [
         "Content-Type": "application/json",
         "Authorization": "Bearer \(token)",
         "cache-control": "no-cache"
      ]
      var request = URLRequest(url: URL(string: "https://api.petfinder.com/v2/animals/\(parameters)")!,
                               cachePolicy: .useProtocolCachePolicy,
                               timeoutInterval: 10.0)
      request.httpMethod = "GET"
      request.allHTTPHeaderFields = headers
      print(request)
      return request
   }
}
