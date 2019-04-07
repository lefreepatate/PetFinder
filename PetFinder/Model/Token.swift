//
//  Token.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 28/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class TokenNumber {
   var code = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjExMzQ4NDFhYzhiZmUwYzA5NmI5NDI0YzkxM2IzZTY4MGFkMWUwMzA3OGY4YmM5ZDE4MWFhNzYyMjBkMTU2MmRhZWZjYjVlY2QyZTVjMzAxIn0.eyJhdWQiOiJySm9URXFyNThMSXBJOFBSbk9iRTlyeEhUVVBrbnE4Sm5KeFk0RmJkamRUUFNxdkNPMSIsImp0aSI6IjExMzQ4NDFhYzhiZmUwYzA5NmI5NDI0YzkxM2IzZTY4MGFkMWUwMzA3OGY4YmM5ZDE4MWFhNzYyMjBkMTU2MmRhZWZjYjVlY2QyZTVjMzAxIiwiaWF0IjoxNTU0NTUzOTY0LCJuYmYiOjE1NTQ1NTM5NjQsImV4cCI6MTU1NDU1NzU2NCwic3ViIjoiIiwic2NvcGVzIjpbXX0.UhPpBBg037R1t1z5A-Uh4LP4cs9CdWh5AapYUFvU7nqgPb0hGwrafH6Qw8jsnnd1G5OAl97OfRBDZIecEYtTHuyFoTT7fcq5soLewbwnEJNkVovtQ0ziElHY7-HHmT5VVS46Ook8aRjLbbHEZMkowbuLB_Unzdro1SPQyHFekRlF3O5F8tUhFhuJtZTeFq9y1ghSWF9mE-UFfrN-yCQkGZl79asybRDaUhxlkjZWWu9dlF8bbxK1iYLWVSRRGDdZzF7Mu47xmnHI3baWB2CzlJP2KWcaJnRTW3joFx8IVmdtDWAYKOKYuvJN8t8V8a7gaiLx9uBkGhWkYlrb8P3e9w"


   func newToken() {
      TokenService.shared.getToken { (success, token) in
         if success, let token = token {
            print("NEW TOKEN :\n\(token)\n")
            self.code = token
         }
      }
   }

}
