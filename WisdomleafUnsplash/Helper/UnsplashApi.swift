//
//  UnsplashApi.swift
//  WisdomleafUnsplash
//
//  Created by Akhand on 11/09/20.
//  Copyright © 2020 Akhand. All rights reserved.
//

import Foundation
import Alamofire
class UnsplashApi {
    static let unsplashEndPoint: String = "/list"
    var isPaginating = false
    
    
    func getAllUnsplash(for page: Int, completion: @escaping ([Unsplash]?)->(), failure: @escaping (Error?, Int)->()) -> HTTPRequestManager {
        let request: HTTPRequestManager = HTTPRequestManager()
        var params: [String: Any] = [:]
        params["page"] = page
        params["limit"] = 10
        isPaginating = true
        
        print(params)
        request.get(UnsplashApi.unsplashEndPoint, params: params, preset: UnsplashApiPreset.getUnsplashApi, headers: nil, completionQueue: nil, success: { (responseData) in
            do {
                if let data: Data = responseData {
                    let decoder: JSONDecoder = JSONDecoder()
                    let unsplash: [Unsplash] = try decoder.decode([Unsplash].self, from: data)
                    completion(unsplash)
                } else {
                    completion(nil)
                }
                self.isPaginating = false
            } catch let error {
                completion(nil)
                print(error)
                self.isPaginating = false
            }
        }) { (error, statusCode) in
            failure(error, statusCode)
            completion(nil)
            self.isPaginating = false
        }
        return request
    }
}
