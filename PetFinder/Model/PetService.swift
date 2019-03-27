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
   
   func getPets(_ callback: @escaping (Bool, [Animal]?) -> Void) {
      let request = createRequest(with: newTokenCode)
      let session = URLSession.shared
      task?.cancel()
      task = session.dataTask(with: request){ (data, response, error) in
         DispatchQueue.main.async {
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
            { return callback(false, nil) }
            guard let data = data, error == nil else { return callback(false, nil)}
            do {
               let decoder = JSONDecoder()
               let response = try decoder.decode(Pets.self, from: data)
               callback(true, response.animals)
            } catch { print(error) }
            }
         
         }
      task?.resume()
      }
   
   func createRequest(with token: String) -> URLRequest {
      let headers = [
         "Content-Type": "application/json",
         "Authorization": "Bearer \(token)",
         "cache-control": "no-cache"
      ]
      var request = URLRequest(url: URL(string: "https://api.petfinder.com/v2/animals?")!,
                               cachePolicy: .useProtocolCachePolicy,
                               timeoutInterval: 10.0)
      request.httpMethod = "GET"
      request.allHTTPHeaderFields = headers
      return request
   }
   
   func checkValidToken() {
      var request = createRequest(with: newTokenCode)
      task?.cancel()
      task = session.dataTask(with: request) { (data, response, error) in
         guard let response = response as? HTTPURLResponse else { return }
         print(response.statusCode)
         if response.statusCode == 401 {
            request = self.createRequest(with: "\(self.newToken())")
         } else {
            print(response.statusCode)
            self.task?.cancel()
         }
      }
      task?.resume()
   }
   
   private func newToken() {
      TokenService.shared.getToken { (success, token) in
         if success, let token = token {
            print("NEW TOKEN :\n\(token)\n")
            self.newTokenCode = token
         }
      }
   }
   var newTokenCode = "***"
}
