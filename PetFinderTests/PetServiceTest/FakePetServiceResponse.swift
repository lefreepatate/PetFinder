//
//  FakePetServiceDataResponse.swift
//  PetFinderTests
//
//  Created by Carlos Garcia-Muskat on 16/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class FakePetServiceResponse {
   
   static var PetCorrectData: Data? {
      let bundle = Bundle(for: FakePetServiceResponse.self)
      let bundleUrl = bundle.url(forResource: "PetSearch", withExtension: "json")
      return try! Data(contentsOf: bundleUrl!)
   }
   
   static var PetCorrectDataWithOptions: Data? {
      let bundle = Bundle(for: FakePetServiceResponse.self)
      let bundleUrl = bundle.url(forResource: "PetSearchWithOptions", withExtension: "json")
      return try! Data(contentsOf: bundleUrl!)
   }
   
   static var PetCorrectDataPetDetail: Data? {
      let bundle = Bundle(for: FakePetServiceResponse.self)
      let bundleUrl = bundle.url(forResource: "PetDetail", withExtension: "json")
      return try! Data(contentsOf: bundleUrl!)
   }
   
   static let responseOK = HTTPURLResponse(url: URL(string: "http://www.petfinder.com")!,
                                           statusCode: 200, httpVersion: nil, headerFields: nil)
   
   static let responseKO = HTTPURLResponse(url: URL(string: "petfinder.com")!,
                                           statusCode: 500, httpVersion: nil, headerFields: nil)
   
   static let incorrectPetData = "erreur".data(using: .utf8)
   
   class PetDataError: Error {}
   static let error = PetDataError()
}
