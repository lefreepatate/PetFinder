//
//  RequestParameters.swift
//  PetFinder
//
//  Created by Carlos Garcia-Muskat on 31/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
// TOKEN + Parameters for request api
struct Parameters {
   var code = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImNlMDRiZDViOTdkNGRjZmZkMzg1MzMyYTI1NGRmNzBlOTc1ZmFmMzk1ZjQ5NjhkOWQzOGE0ZDllYmVmYTA2Zjk3NmI5MjI0ZDFjNjNlNTM5In0.eyJhdWQiOiJySm9URXFyNThMSXBJOFBSbk9iRTlyeEhUVVBrbnE4Sm5KeFk0RmJkamRUUFNxdkNPMSIsImp0aSI6ImNlMDRiZDViOTdkNGRjZmZkMzg1MzMyYTI1NGRmNzBlOTc1ZmFmMzk1ZjQ5NjhkOWQzOGE0ZDllYmVmYTA2Zjk3NmI5MjI0ZDFjNjNlNTM5IiwiaWF0IjoxNTU1OTQxMjA3LCJuYmYiOjE1NTU5NDEyMDcsImV4cCI6MTU1NTk0NDgwNywic3ViIjoiIiwic2NvcGVzIjpbXX0.QXod5ztrphGx4HnDE58FR9Vf9pBQElj3icfroX8JROPsk5IWf4OA0WVSV7vyuy2qYMWbOvoFh7OUc4vG4R0YAJIZaF0CHeFU3V7UPen3dof93llD1Hc2Zz6gPgNZnAaJU_bBk5NbvMWOAVUTh5A1fsEZYIn8KY2Wdy6leGTDq3eUblxrMwPIJcloePQFmQ1Rr4rG01Wcmo9sY63dHrh_uqsnNg-1K-E5k_g5vz4zo9G2bIhbnSHB_zUOCAu13Po8LJZbiyE3rhu5NY4NsSEU_eB8RjMhAMBl0pW9_Gu5SeTH3kUEq66SjB5_TPnHdtXG5Q-SezDX_Mv-W32Xshq9oA"
   
   
   var id = String()
   var location = String()
   var distance = Int()
   var type = String()
   var age = String()
   var breed = String()
   var size = String()
   var gender = String()
   var color = String()
   var environnement = String()
}
