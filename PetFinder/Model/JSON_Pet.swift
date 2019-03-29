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
}

struct Attributes: Codable {
   let spayedNeutered, houseTrained: Bool?
   let declawed: Bool?
   let specialNeeds, shotsCurrent: Bool?
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
}

struct PaginationLinks: Codable {
   let next: Next?
}
