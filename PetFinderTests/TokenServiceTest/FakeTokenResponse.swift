//
//  FakePetServiceDataResponse.swift
//  PetFinderTests
//
//  Created by Carlos Garcia-Muskat on 16/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class FakeTokenResponse {
   
   static var TokenCorrectData: Data? {
      let bundle = Bundle(for: FakeTokenResponse.self)
      let bundleUrl = bundle.url(forResource: "NewToken", withExtension: "json")
      return try! Data(contentsOf: bundleUrl!)
   }
   
   static let responseOK = HTTPURLResponse(url: URL(string: "http://www.petfinder.com")!,
                                           statusCode: 200, httpVersion: nil, headerFields: nil)
   
   static let responseKO = HTTPURLResponse(url: URL(string: "petfinder.com")!,
                                           statusCode: 401, httpVersion: nil, headerFields: nil)
   
   static let tokenIncorrectData = "erreur".data(using: .utf8)
   
   class TokenDataError: Error {}
   static let error = TokenDataError()
}
