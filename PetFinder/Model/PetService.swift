//
//  PetService.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 24/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class PetService {
   
   static var shared = PetService()
   init() {}
   
   private var task: URLSessionDataTask?
   // MARK: -- FAKE DATATASK FOR TESTING
   private var session = URLSession.init(configuration: .default)
   init(session: URLSession) {
      self.session = session
   }
   // MARK: -- GET GOOGLE TRANSLATE
   func getToken(_ callBack: @escaping (Bool, String?) -> Void) {
      let headers = ["content-type": "application/json"]
      let parameters = [
         "grant_type": "client_credentials",
         "client_id": "***",
         "client_secret": "***",
         "redirect_uri": "https://api.petfinder.com/v2/animals?"
      ]
      
      let postData = try? JSONSerialization.data(withJSONObject: parameters, options: .sortedKeys)
      
      var request = URLRequest(url: URL(string: "https://api.petfinder.com/v2/oauth2/token")!,
                               cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
      
      request.httpMethod = "POST"
      request.allHTTPHeaderFields = headers
      request.httpBody = postData
      
      let session = URLSession.shared
      let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
         DispatchQueue.main.async {
            guard let data = data, error == nil else {
               callBack(false, nil)
               return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
               callBack(false, nil)
               return
            }
            guard let responseJSON = try? JSONDecoder().decode(Token.self, from: data) else {return}
            print(responseJSON.accessToken)
            callBack(true, responseJSON.accessToken)
         }
      })
      dataTask.resume()
   }
}
