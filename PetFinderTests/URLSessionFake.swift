//
//  URLSessionFake.swift
//  PetFinderTests
//
//  Created by Carlos Garcia-Muskat on 16/04/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class URLSessionFake: URLSession {
   var data: Data?
   var response: URLResponse?
   var error: Error?
   
   init(data: Data?, response: URLResponse?, error: Error?){
      self.data = data
      self.response = response
      self.error = error
   }
   
   override func dataTask(with request: URLRequest, completionHandler:
      @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
      let task = FakeURLSessionDataTask()
      task.completionHandler = completionHandler
      task.data = data
      task.urlResponse = response
      task.responseError = error
      return task
   }
}

class FakeURLSessionDataTask: URLSessionDataTask {
   var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
   var data: Data?
   var urlResponse: URLResponse?
   var responseError: Error?
   
   override func resume() {
      completionHandler?(data, urlResponse, responseError)
   }
}
