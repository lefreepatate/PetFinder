//
//  JSON_Token.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 25/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

struct Token: Codable {
   let tokenType: String
   let expiresIn: Int
   let accessToken: String?
   
   enum CodingKeys: String, CodingKey {
      case tokenType = "token_type"
      case expiresIn = "expires_in"
      case accessToken = "access_token"
   }
}
