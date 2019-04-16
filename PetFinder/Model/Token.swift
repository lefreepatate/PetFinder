//
//  Token.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 28/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class TokenNumber {
   var code = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjM4YzlmNWE3MDZmODFmYjkzYzYwYTY4NTE4NmM5ZmY0OTA1NWQ2MmZiZWQ2ZmJhNWViMjYwYmNmOGY0NzAxODczMGE3YjliMjU3OTYwMzAzIn0.eyJhdWQiOiJySm9URXFyNThMSXBJOFBSbk9iRTlyeEhUVVBrbnE4Sm5KeFk0RmJkamRUUFNxdkNPMSIsImp0aSI6IjM4YzlmNWE3MDZmODFmYjkzYzYwYTY4NTE4NmM5ZmY0OTA1NWQ2MmZiZWQ2ZmJhNWViMjYwYmNmOGY0NzAxODczMGE3YjliMjU3OTYwMzAzIiwiaWF0IjoxNTU1NDE4NjY2LCJuYmYiOjE1NTU0MTg2NjYsImV4cCI6MTU1NTQyMjI2Niwic3ViIjoiIiwic2NvcGVzIjpbXX0.cgeAdnb_xgMvYenv0NiwX0jxfAukpGaxebPYLV60lA8RumyoxOCCg2ZDdRdy7SAKjpko7M92auFFbMvvBb_3wsmCX0J5dq_QkjH5LhSKxFi2h5wF0nxkH0DcJFcFR685KR5oCQWtgGGDEQTW1HjesFoKGsxlxUJrUe-y1boVwKMn389dmi5BHXxxRHWZB4a1VAknkD-u1579bxjNnzkeiVrWNAlgTy-0dUw8bRFk1WZkk49otCP8M-X7s-95vAaENPf6TrMJ4XnFTisaYBNVlE77tFy72Il7-ECJUHilcrVsrjasBs-GevwdUtRP6GBiH7m0szQGICrqEJI9Fv9wIw"
   
   func newToken() {
      TokenService.shared.getToken { (success, token) in
         if success, let token = token {
            print("NEW TOKEN :\n\(token)\n")
            self.code = token
         }
      }
   }

}
