//
//  JSON_PetService.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 25/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
// To parse the JSON, add this file to your project and do:
//
//   let petFinder = try? newJSONDecoder().decode(PetFinder.self, from: jsonData)

import Foundation

struct PetFinder: Decodable {
   let animals: [Animal]?
   let pagination: Pagination
   
   enum CodingKeys: String, CodingKey {
      case animals = "animals"
      case pagination = "pagination"
   }
}

struct Animal: Decodable {
   let id: Int
   let organizationid: String
   let url: String
   let type: Species
   let species: Species
   let breeds: Breeds
   let colors: Colors
   let age: Age
   let gender: Gender
   let size: Size
   let coat: Coat?
   let attributes: Attributes
   let environment: Environment
   let tags: [String]
   let name: String
   let description: String
   let photos: [Photo]
   let status: Status
   let publishedAt: Date
   let contact: Contact
   let links: AnimalLinks
   
   enum CodingKeys: String, CodingKey {
      case id = "id"
      case organizationid = "organization_id"
      case url = "url"
      case type = "type"
      case species = "species"
      case breeds = "breeds"
      case colors = "colors"
      case age = "age"
      case gender = "gender"
      case size = "size"
      case coat = "coat"
      case attributes = "attributes"
      case environment = "environment"
      case tags = "tags"
      case name = "name"
      case description = "description"
      case photos = "photos"
      case status = "status"
      case publishedAt = "published_at"
      case contact = "contact"
      case links = "_links"
   }
}

enum Age: String, Decodable {
   case adult = "Adult"
   case baby = "Baby"
   case senior = "Senior"
   case young = "Young"
}

struct Attributes: Decodable {
   let spayedNeutered: Bool
   let houseTrained: Bool
   let declawed: Bool?
   let specialNeeds: Bool
   let shotsCurrent: Bool
   
   enum CodingKeys: String, CodingKey {
      case spayedNeutered = "spayed_neutered"
      case houseTrained = "house_trained"
      case declawed = "declawed"
      case specialNeeds = "special_needs"
      case shotsCurrent = "shots_current"
   }
}

struct Breeds: Decodable {
   let primary: String
   let secondary: String?
   let mixed: Bool
   let unknown: Bool
   
   enum CodingKeys: String, CodingKey {
      case primary = "primary"
      case secondary = "secondary"
      case mixed = "mixed"
      case unknown = "unknown"
   }
}

enum Coat: String, Decodable {
   case medium = "Medium"
   case short = "Short"
}

struct Colors: Decodable {
   let primary: String?
   let secondary: String?
   let tertiary: JSONNull?
   
   enum CodingKeys: String, CodingKey {
      case primary = "primary"
      case secondary = "secondary"
      case tertiary = "tertiary"
   }
}

struct Contact: Decodable {
   let email: String
   let phone: String?
   let address: Address
   
   enum CodingKeys: String, CodingKey {
      case email = "email"
      case phone = "phone"
      case address = "address"
   }
}

struct Address: Decodable {
   let address1: String?
   let address2: String?
   let city: String
   let state: String
   let postcode: String
   let country: Country
   
   enum CodingKeys: String, CodingKey {
      case address1 = "address1"
      case address2 = "address2"
      case city = "city"
      case state = "state"
      case postcode = "postcode"
      case country = "country"
   }
}

enum Country: String, Decodable {
   case us = "US"
}

struct Environment: Decodable {
   let children: Bool?
   let dogs: Bool?
   let cats: Bool?
   
   enum CodingKeys: String, CodingKey {
      case children = "children"
      case dogs = "dogs"
      case cats = "cats"
   }
}

enum Gender: String, Decodable {
   case female = "Female"
   case male = "Male"
}

struct AnimalLinks: Decodable {
   let linksSelf: Next
   let type: Next
   let organization: Next
   
   enum CodingKeys: String, CodingKey {
      case linksSelf = "self"
      case type = "type"
      case organization = "organization"
   }
}

struct Next: Decodable {
   let href: String
   
   enum CodingKeys: String, CodingKey {
      case href = "href"
   }
}

struct Photo: Decodable {
   let small: String
   let medium: String
   let large: String
   let full: String
   
   enum CodingKeys: String, CodingKey {
      case small = "small"
      case medium = "medium"
      case large = "large"
      case full = "full"
   }
}

enum Size: String, Decodable {
   case large = "Large"
   case medium = "Medium"
   case small = "Small"
}

enum Species: String, Decodable {
   case cat = "Cat"
   case dog = "Dog"
}

enum Status: String, Decodable {
   case adoptable = "adoptable"
}

struct Pagination: Decodable {
   let countPerPage: Int
   let totalCount: Int
   let currentPage: Int
   let totalPages: Int
   let links: PaginationLinks
   
   enum CodingKeys: String, CodingKey {
      case countPerPage = "count_per_page"
      case totalCount = "total_count"
      case currentPage = "current_page"
      case totalPages = "total_pages"
      case links = "_links"
   }
}

struct PaginationLinks: Decodable {
   let next: Next
   
   enum CodingKeys: String, CodingKey {
      case next = "next"
   }
}

// MARK: Encode/decode helpers

class JSONNull: Decodable, Hashable {
   
   public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
      return true
   }
   
   public var hashValue: Int {
      return 0
   }
   
   public init() {}
   
   public required init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      if !container.decodeNil() {
         throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
      }
   }
   
   public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      try container.encodeNil()
   }
}

