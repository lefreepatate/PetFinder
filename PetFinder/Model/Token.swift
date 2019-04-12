//
//  Token.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 28/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class TokenNumber {
   var code = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjI5YzNiNGIwZTM5MTE3ZjhjNjE1NDczNmRlYmExNzZkNDcxOWU3MDM4NzI1YTY0YTc3NjM5MDhlOTc1ZTFlMzk0NDkzNzg1ZDFiZTJhMTZlIn0.eyJhdWQiOiJySm9URXFyNThMSXBJOFBSbk9iRTlyeEhUVVBrbnE4Sm5KeFk0RmJkamRUUFNxdkNPMSIsImp0aSI6IjI5YzNiNGIwZTM5MTE3ZjhjNjE1NDczNmRlYmExNzZkNDcxOWU3MDM4NzI1YTY0YTc3NjM5MDhlOTc1ZTFlMzk0NDkzNzg1ZDFiZTJhMTZlIiwiaWF0IjoxNTU0OTk0ODg3LCJuYmYiOjE1NTQ5OTQ4ODcsImV4cCI6MTU1NDk5ODQ4Nywic3ViIjoiIiwic2NvcGVzIjpbXX0.l0KAxTnZUQrQ5iGufswWnx_SMXgv1P3rG3hClvFcu5U9S3aULfZ13D40sMRox4gkTQD7CDeGbzYVrwkB3xdv_3Nl0ifrCcHu9H3qb0aeokilPbNHDrtLYjTOLfMd1wHJM8qHg-V4YxMRrYGLLJGgCGozkwyPpLISh80_0B8gs4CDm50WSXF0BYRDGvI2FzEVqbpJKk0cXvwub-Rvq1Y4BvYuMnP1qgpDscfEIUohc-iK7gl78PxKCH1s7p-jlakIw0liXADRog7gr8O6TmanAdXbL0h3X86gyh7DyCOfwh32ZamppzzkSuem_LkxAqsvgu-ABa7oNOnlPWrrXUGS9w"
   
   func newToken() {
      TokenService.shared.getToken { (success, token) in
         if success, let token = token {
            print("NEW TOKEN :\n\(token)\n")
            self.code = token
         }
      }
   }

}
