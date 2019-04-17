//
//  PetFinderTests.swift
//  PetFinderTests
//
//  Created by Carlos Garcia-Muskat on 24/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import XCTest
@testable import PetFinder

class PetFinderServiceTests: XCTestCase {
   
   var fakePetSearch: PetService!
   var success: Bool!
   var pets: [Animal]?
   var pet: Animal?
   var parameters = Parameters()
   var petId = "44482552"
   override func setUp() {
      super.setUp()
      fakePetSearch = PetService()
      success = Bool()
   }
   func getPetResponse(parameterID: String, sessionData: Foundation.Data?,
                       response: URLResponse?, error: Error?)
   {
      let expectation = XCTestExpectation(description: "Wait for queue change")
      fakePetSearch = PetService(session: URLSessionFake(data: sessionData, response: response, error: error))
      parameters.id = parameterID
      fakePetSearch.parameters.id = parameterID
      fakePetSearch.getPets { (success, response) in
        expectation.fulfill()
         print(self.parameters)
         if success && !self.parameters.id.isEmpty, let response = response as! Animal? {
            self.pet = response
            self.success = success
         }
         else if success, let response = response as! [Animal]? {
            self.pets = response
            self.success = success
         }
      }
      wait(for: [expectation], timeout: 0.05)
   }
   
   func testGivenEmptyAgeWhenAddingAgeTypeThenAgeParametersIsNotEmpty() {
      let ageType = "Adult"
      fakePetSearch.parameters.age.append(ageType)
      XCTAssertNotNil(fakePetSearch.parameters.age)
      XCTAssertFalse(fakePetSearch.parameters.age.isEmpty)
   }
   func testGivenEmptyBreedWhenAddingBreedTypeThenBreedParametersIsNotEmpty() {
      let breed = "German Shepherd Dog"
      fakePetSearch.parameters.breed.append(breed)
      XCTAssertNotNil(fakePetSearch.parameters.breed)
      XCTAssertFalse(fakePetSearch.parameters.breed.isEmpty)
   }
   func testGivenEmptySizeWhenAddingSizeTypeThenSizeParametersIsNotEmpty() {
      let size = "Medium"
      fakePetSearch.parameters.size.append(size)
      XCTAssertNotNil(fakePetSearch.parameters.size)
      XCTAssertFalse(fakePetSearch.parameters.size.isEmpty)
   }
   func testGivenEmptyGenderWhenAddingGenderTypeThenGenderParametersIsNotEmpty() {
      let gender = "Female"
      fakePetSearch.parameters.gender.append(gender)
      XCTAssertNotNil(fakePetSearch.parameters.gender)
      XCTAssertFalse(fakePetSearch.parameters.gender.isEmpty)
   }
   func testGivenEmptyColorWhenAddingColorTypeThenColorParametersIsNotEmpty() {
      let color = "Bicolor"
      fakePetSearch.parameters.color.append(color)
      XCTAssertNotNil(fakePetSearch.parameters.color)
      XCTAssertFalse(fakePetSearch.parameters.color.isEmpty)
   }
   func testGivenEmptyIDWhenAddingIDTypeThenIDParametersIsNotEmpty() {
      let id = "44482552"
      fakePetSearch.parameters.id.append(id)
      XCTAssertNotNil(fakePetSearch.parameters.id)
      XCTAssertFalse(fakePetSearch.parameters.id.isEmpty)
   }
   func testGivenEmptyEnvironnementWhenAddingEnvironnementTypeThenEnvironnementParametersIsNotEmpty() {
      let environnement = "dogs"
      fakePetSearch.parameters.environnement.append(environnement)
      XCTAssertNotNil(fakePetSearch.parameters.environnement)
      XCTAssertFalse(fakePetSearch.parameters.environnement.isEmpty)
   }
   
   func testGivenEmptyLocationWhenAddingLocationTypeThenLocationParametersIsNotEmpty() {
      let location = "New‰20York"
      fakePetSearch.parameters.location = location
      XCTAssertNotNil(fakePetSearch.parameters.location)
      XCTAssertEqual(location, fakePetSearch.parameters.location)
   }
   
   func testGivenEmptyDistanceWhenAddingDistanceTypeThenDistanceParametersIsNotEmpty() {
      let distance = 50
      fakePetSearch.parameters.distance = distance
      XCTAssertNotNil(fakePetSearch.parameters.distance)
      XCTAssertEqual(distance, fakePetSearch.parameters.distance)
   }
   
   func testPetServiceShouldPostFailedCallBackIfError() {
      getPetResponse(parameterID: "", sessionData: nil, response: nil, error: FakePetServiceResponse.error)
      XCTAssertNil(pets)
      XCTAssertFalse(success)
   }
   
   func testPetServiceShouldPostFailedCallBackIfNoData() {
      getPetResponse(parameterID: "", sessionData: nil, response: nil, error: nil)
      XCTAssertNil(pets)
      XCTAssertFalse(success)
   }
   
   func testPetServiceShouldPostFailedCallBackIfIncorrectData() {
      getPetResponse(parameterID: "", sessionData: FakePetServiceResponse.incorrectPetData, response: nil, error: nil)
      XCTAssertNil(pets)
      XCTAssertFalse(success)
   }
   
   func testPetServiceShouldPostFailedCallBackIfResponse500() {
      getPetResponse(parameterID: "", sessionData: nil, response: FakePetServiceResponse.responseKO, error: nil)
      XCTAssertNil(pets)
      XCTAssertFalse(success)
   }
   
   func testPetServiceShouldPostSuccessCallBackIfCorrectData() {
      getPetResponse(parameterID: "", sessionData: FakePetServiceResponse.PetCorrectData, response: FakePetServiceResponse.responseOK, error: nil)
      XCTAssertTrue(success)
      XCTAssertNotNil(pets)
      XCTAssertEqual(pets?[0].age, "Young")
   }
   func testPetServiceShouldPostSuccessCallBackIfCorrectDataWithOptions() {
      getPetResponse(parameterID: "", sessionData: FakePetServiceResponse.PetCorrectDataWithOptions, response: FakePetServiceResponse.responseOK, error: nil)
      XCTAssertTrue(success)
      XCTAssertNotNil(pets)
      XCTAssertEqual(pets?[0].name, "Cocoa")
   }
   func testPetServiceShouldPostSuccessCallBackIfCorrectDataWithPetDetail() {
      getPetResponse(parameterID: "44482552", sessionData: FakePetServiceResponse.PetCorrectDataPetDetail, response: FakePetServiceResponse.responseOK, error: nil)
      XCTAssertTrue(success)
      XCTAssertNotNil(pet)
      XCTAssertEqual(pet?.id, 44482552)
      XCTAssertEqual(pet?.name, "Zeus")
      XCTAssertEqual(pet?.breeds?.primary, "Husky")
   }
   
   func testCheckTokenServiceWhenHTTPResponseIS401() {
      fakePetSearch = PetService(session: URLSessionFake(data: FakeTokenResponse.TokenCorrectData,
                                                         response:FakeTokenResponse.responseOK, error: nil))
      fakePetSearch.checkToken()
      
   }
}
