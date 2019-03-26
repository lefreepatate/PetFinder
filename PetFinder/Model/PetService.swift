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
   var newTokenCode = "***"
   func newToken() {
      TokenService.shared.getToken { (success, token) in
         if success, let token = token {
            print("NEW TOKEN :\n\(token)\n")
            self.newTokenCode = token
         }
      }
   }
   
   func getPets(_ callback: @escaping (Bool?, [Animal]?) -> Void) {
      var request = createRequest(with: newTokenCode)
      
      let session = URLSession.shared
      task?.cancel()
      task = session.dataTask(with: request) { (data, response, error) in
         guard let httpResponse = response as? HTTPURLResponse else { return callback(false, nil)}
         if let responseData = data, httpResponse.statusCode == 200 {
            print("Have some data \(responseData)")
            do {
               let json = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments)
               callback(true, json as? [Animal])
               print(json)
            } catch {
               callback(false, nil)
               print("JSon failed")
            }
         } else if httpResponse.statusCode == 401 {
            request = self.createRequest(with: "\(self.newToken())")
            self.task?.cancel()
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
      
      var request = URLRequest(url: URL(string: "https://api.petfinder.com/v2/animals")!,
                               cachePolicy: .useProtocolCachePolicy,
                               timeoutInterval: 10.0)
      request.httpMethod = "GET"
      request.allHTTPHeaderFields = headers
      return request
   }
}
