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
                       response: URLResponse?, error: Error?) {
      
      let expectation = XCTestExpectation(description: "Wait for queue change")
      fakePetSearch = PetService(session: URLSessionFake(data: sessionData, response: response, error: error))
      if parameterID != "" {
      parameters.id = parameterID
      }
      PetService.parameters.id = parameterID
      fakePetSearch.getPets { (success, response) in
         expectation.fulfill()
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
      PetService.parameters.age.append(ageType)
      XCTAssertNotNil(PetService.parameters.age)
      XCTAssertFalse(PetService.parameters.age.isEmpty)
   }
   func testGivenEmptyBreedWhenAddingBreedTypeThenBreedParametersIsNotEmpty() {
      let breed = "German%20Shepherd%20Dog"
      PetService.parameters.breed.append(breed)
      XCTAssertNotNil(PetService.parameters.breed)
      XCTAssertFalse(PetService.parameters.breed.isEmpty)
   }
   func testGivenEmptySizeWhenAddingSizeTypeThenSizeParametersIsNotEmpty() {
      let size = "Medium"
      PetService.parameters.size.append(size)
      XCTAssertNotNil(PetService.parameters.size)
      XCTAssertFalse(PetService.parameters.size.isEmpty)
   }
   func testGivenEmptyGenderWhenAddingGenderTypeThenGenderParametersIsNotEmpty() {
      let gender = "Female"
      PetService.parameters.gender.append(gender)
      XCTAssertNotNil(PetService.parameters.gender)
      XCTAssertFalse(PetService.parameters.gender.isEmpty)
   }
   func testGivenEmptyColorWhenAddingColorTypeThenColorParametersIsNotEmpty() {
      let color = "Bicolor"
      PetService.parameters.color.append(color)
      XCTAssertNotNil(PetService.parameters.color)
      XCTAssertFalse(PetService.parameters.color.isEmpty)
   }
   func testGivenEmptyIDWhenAddingIDTypeThenIDParametersIsNotEmpty() {
      let id = "44482552"
      PetService.parameters.id.append(id)
      XCTAssertNotNil(PetService.parameters.id)
      XCTAssertFalse(PetService.parameters.id.isEmpty)
   }
   func testGivenEmptyEnvironnementWhenAddingEnvironnementTypeThenParametersIsNotEmpty() {
      let environnement = "dogs"
      PetService.parameters.environnement.append(environnement)
      XCTAssertNotNil(PetService.parameters.environnement)
      XCTAssertFalse(PetService.parameters.environnement.isEmpty)
   }
   
   func testGivenEmptyLocationWhenAddingLocationTypeThenLocationParametersIsNotEmpty() {
      let location = "New%20York"
      PetService.parameters.location = location
      XCTAssertNotNil(PetService.parameters.location)
      XCTAssertEqual(location, PetService.parameters.location)
   }
   
   func testGivenEmptyDistanceWhenAddingDistanceTypeThenDistanceParametersIsNotEmpty() {
      let distance = "50"
      PetService.parameters.distance = distance
      XCTAssertNotNil(PetService.parameters.distance)
      XCTAssertEqual(distance, PetService.parameters.distance)
   }
   
   func testPetServiceShouldPostFailedCallBackIfError() {
      getPetResponse(parameterID: "", sessionData: nil,
                     response: nil, error: FakePetServiceResponse.error)
      XCTAssertNil(pets)
      XCTAssertFalse(success)
   }
   
   func testPetServiceShouldPostFailedCallBackIfNoData() {
      getPetResponse(parameterID: "", sessionData: nil, response: nil, error: nil)
      XCTAssertNil(pets)
      XCTAssertFalse(success)
   }
   
   func testPetServiceShouldPostFailedCallBackIfIncorrectData() {
      getPetResponse(parameterID: "", sessionData: FakePetServiceResponse.incorrectPetData,
                     response: nil, error: nil)
      XCTAssertNil(pets)
      XCTAssertFalse(success)
   }
   
   func testPetServiceShouldPostFailedCallBackIfResponse500() {
      getPetResponse(parameterID: "", sessionData: nil,
                     response: FakePetServiceResponse.responseKO, error: nil)
      XCTAssertNil(pets)
      XCTAssertFalse(success)
   }
   
   func testPetServiceShouldPostFailedCallBackIfResponse401() {
      getPetResponse(parameterID: "", sessionData: nil,
                     response: FakePetServiceResponse.responseToken, error: nil)
      XCTAssertNil(pets)
      XCTAssertFalse(success)
   }
   
   func testPetServiceShouldPostSuccessCallBackIfCorrectData() {
      getPetResponse(parameterID: "", sessionData: FakePetServiceResponse.PetCorrectData,
                     response: FakePetServiceResponse.responseOK, error: nil)
      XCTAssertTrue(success)
      XCTAssertNotNil(pets)
      XCTAssertEqual(pets?[0].age, "Young")
   }
   func testPetServiceShouldPostSuccessCallBackIfCorrectDataWithOptions() {
      getPetResponse(parameterID: "", sessionData: FakePetServiceResponse.PetCorrectDataWithOptions,
                     response: FakePetServiceResponse.responseOK, error: nil)
      XCTAssertTrue(success)
      XCTAssertNotNil(pets)
      XCTAssertEqual(pets?[0].name, "Cocoa")
   }
   func testPetServiceShouldPostSuccessCallBackIfCorrectDataWithPetDetail() {
      getPetResponse(parameterID: "44482552",
                     sessionData: FakePetServiceResponse.PetCorrectDataPetDetail,
                     response: FakePetServiceResponse.responseOK, error: nil)
      XCTAssertTrue(success)
      XCTAssertNotNil(pet)
      XCTAssertEqual(pet?.id, 44482552)
      XCTAssertEqual(pet?.name, "Zeus")
      XCTAssertEqual(pet?.breeds?.primary, "Husky")
   }
   
   func testCheckTokenServiceWhenHTTPResponseIS401() {
      fakePetSearch = PetService(session: URLSessionFake(
         data: FakeTokenResponse.TokenCorrectData,
         response:FakeTokenResponse.responseOK, error: nil))
      fakePetSearch.checkToken()
      
   }
}
