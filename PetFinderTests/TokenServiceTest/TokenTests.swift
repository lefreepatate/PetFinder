//
//  PetFinderTests.swift
//  PetFinderTests
//
//  Created by Carlos Garcia-Muskat on 24/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import XCTest
@testable import PetFinder

class TokenTest: XCTestCase {
   var fakePetSearch: PetService!
   var fakeToken: TokenService!
   var success: Bool!
   var token:String!
   override func setUp() {
      super.setUp()
      fakeToken = TokenService()
      fakePetSearch = PetService()
      success = Bool()
   }
   func getTokenResponse(sessionData: Foundation.Data?,
                       response: URLResponse?, error: Error?) {
      
      let expectation = XCTestExpectation(description: "Wait for queue change")
      
      fakeToken = TokenService(session: URLSessionFake(data: sessionData, response: response, error: error))
      fakeToken.getToken { (success, response) in
         expectation.fulfill()
         if success, let response = response {
            self.token = response
            self.success = success
         }
      }
      wait(for: [expectation], timeout: 0.05)
   }
   
   func testCheckTokenServiceWhenHTTPResponseIS401() {
      fakePetSearch = PetService(session: URLSessionFake(data: FakeTokenResponse.TokenCorrectData,
                                                         response:FakeTokenResponse.responseKO, error: nil))
      getTokenResponse(sessionData: FakeTokenResponse.TokenCorrectData,
                       response:FakeTokenResponse.responseKO, error: nil)
      fakePetSearch.checkToken()
      XCTAssertFalse(success)
      XCTAssertNil(token)
   }
   
   func testGettingNewTokenWhenHTTPResponseIS401() {
      fakePetSearch.checkToken()
      getTokenResponse(sessionData: FakeTokenResponse.TokenCorrectData,
                       response:FakeTokenResponse.responseOK, error: nil)
      XCTAssertTrue(success)
      XCTAssertNotNil(token)
   }
}
