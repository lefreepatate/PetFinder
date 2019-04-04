//
//  Token.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 28/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class TokenNumber {
   var code = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjA3NWJkMDIwZjVjMDA5NDliY2JhNmExN2RlMWRlYTdmN2NmZTliZmUyZTM4OWMzNjYzMzAzZDU0ODViOTIwOTI2MjdlMzZmNTFlYWNhOWIyIn0.eyJhdWQiOiJySm9URXFyNThMSXBJOFBSbk9iRTlyeEhUVVBrbnE4Sm5KeFk0RmJkamRUUFNxdkNPMSIsImp0aSI6IjA3NWJkMDIwZjVjMDA5NDliY2JhNmExN2RlMWRlYTdmN2NmZTliZmUyZTM4OWMzNjYzMzAzZDU0ODViOTIwOTI2MjdlMzZmNTFlYWNhOWIyIiwiaWF0IjoxNTU0MzkyODI5LCJuYmYiOjE1NTQzOTI4MjksImV4cCI6MTU1NDM5NjQyOSwic3ViIjoiIiwic2NvcGVzIjpbXX0.jfSIHsDq76dNkzVOH_83XL3aZHZroIJ-dohN5aUc86QlW7GuvCyKxu1wYLJTiXNaxLcSd5BjlGCKfcDZWMXtmhq92YsOsaRe5A1pj9_WaOmJ4VnvYqQJUBcelY-1cwwHzFrM5pF0tAKM9pe23j4mHTArdD3ubRjUqL3jkQsY00tI9vQ8ABu8MqOJJTb6eTlYxVaNDxMc8ob5aiidH6FRADEp0VWQGGdLb6nsaN6LM5NwAs6vHaIJFlkxH5YvtGVXzCN1qk2Mc_3Q3gQrjWUNyEXl5_I3r83PSt-w9GHLoWc4bD9vbrBsQJZAmqBmx9Z5keY8HcOhM_H5fMoRrZa77w"


   func newToken() {
      TokenService.shared.getToken { (success, token) in
         if success, let token = token {
            print("NEW TOKEN :\n\(token)\n")
            self.code = token
         }
      }
   }

}
