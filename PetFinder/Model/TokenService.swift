//
//  PetService.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 24/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class TokenService {
   
   static var shared = TokenService()
   init() {}
   
   private var task: URLSessionDataTask?
   // MARK: -- FAKE DATATASK FOR TESTING
   private var session = URLSession.init(configuration: .default)
   init(session: URLSession) {
      self.session = session
   }
   // MARK: -- GET REFRESH TOKEN CODE
   func getToken(_ callBack: @escaping (Bool, String?) -> Void) {
      let request = requestToken()
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
            guard let responseJSON = try? JSONDecoder().decode(Token.self, from: data),
            let accessToken = responseJSON.accessToken else {return}
            callBack(true, accessToken)
         }
      })
      dataTask.resume()
   }
   
   func requestToken() -> URLRequest {
      let headers = ["content-type": "application/json"]
      let parameters = [
         "grant_type": "client_credentials",
         "client_id": "rJoTEqr58LIpI8PRnObE9rxHTUPknq8JnJxY4FbdjdTPSqvCO1",
         "client_secret": "ZHyEpYCHycEHivcUvvJpGnfCcUEdxdSrtRbirthj",
         "redirect_uri": "https://api.petfinder.com/v2/animals?"
      ]
      
      let postData = try? JSONSerialization.data(withJSONObject: parameters, options: .sortedKeys)
      
      var request = URLRequest(url: URL(string: "https://api.petfinder.com/v2/oauth2/token")!,
                               cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
      
      request.httpMethod = "POST"
      request.allHTTPHeaderFields = headers
      request.httpBody = postData
      return request
   }
}
