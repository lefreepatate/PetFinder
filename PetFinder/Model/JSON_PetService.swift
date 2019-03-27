//
//  JSON_PetService.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 25/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.


import Foundation

struct Pets: Codable {
   let animals: [Animal]?
   let pagination: Pagination?
}

struct Animal: Codable {
   let id: Int?
   let organizationId: String?
   let url: String?
   let type, species: String?
   let breeds: Breeds?
   let colors: Colors?
   let age, gender, size: String?
   let coat: String?
   let attributes: Attributes?
   let environment: Environment?
   let tags: [String]?
   let name: String?
   let description: String?
   let photos: [Photo]?
   let status, publishedAt: String?
   let contact: Contact?
   let links: AnimalLinks?
   
   enum CodingKeys: String, CodingKey {
      case id
      case organizationId = "organization_id"
      case url, type, species, breeds, colors, age, gender, size, coat, attributes, environment, tags, name, description, photos, status
      case publishedAt = "published_at"
      case contact
      case links = "_links"
   }
}

struct Attributes: Codable {
   let spayedNeutered, houseTrained: Bool?
   let declawed: Bool?
   let specialNeeds, shotsCurrent: Bool?
   
   enum CodingKeys: String, CodingKey {
      case spayedNeutered = "spayed_neutered"
      case houseTrained = "house_trained"
      case declawed
      case specialNeeds = "special_needs"
      case shotsCurrent = "shots_current"
   }
}

struct Breeds: Codable {
   let primary: String?
   let secondary: String?
   let mixed, unknown: Bool?
}

struct Colors: Codable {
   let primary, secondary: String?
   let tertiary: String?
}

struct Contact: Codable {
   let email: String?
   let phone: String?
   let address: Address?
}

struct Address: Codable {
   let address1: String?
   let address2: String?
   let city, state, postcode, country: String?
}

struct Environment: Codable {
   let children, dogs, cats: Bool?
}

struct AnimalLinks: Codable {
   let linksSelf, type, organization: Next?
   
   enum CodingKeys: String, CodingKey {
      case linksSelf = "self"
      case type, organization
   }
}

struct Next: Codable {
   let href: String?
}

struct Photo: Codable {
   let small, medium, large, full: String?
}

struct Pagination: Codable {
   let countPerPage, totalCount, currentPage, totalPages: Int?
   let links: PaginationLinks?
   
   enum CodingKeys: String, CodingKey {
      case countPerPage = "count_per_page"
      case totalCount = "total_count"
      case currentPage = "current_page"
      case totalPages = "total_pages"
      case links = "_links"
   }
}

struct PaginationLinks: Codable {
   let next: Next?
}
