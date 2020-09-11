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



func getAllUnsplash(for page: Int, completion: @escaping ([Unsplash]?)->(), failure: @escaping (Error?, Int)->()) -> HTTPRequestManager {
    let request: HTTPRequestManager = HTTPRequestManager()
    var params: [String: Any] = [:]

    params["page"] = page
    params["limit"] = 10

    print(params)
    request.get(UnsplashApi.unsplashEndPoint, params: params, preset: UnsplashApiPreset.getReportApi, headers: nil, completionQueue: nil, success: { (responseData) in
        do {
            if let data: Data = responseData {
                let decoder: JSONDecoder = JSONDecoder()
                let unsplash: [Unsplash] = try decoder.decode([Unsplash].self, from: data)
                completion(unsplash)
            } else {
                completion(nil)
            }
        } catch let error {
            completion(nil)
            print(error)
        }
    }) { (error, statusCode) in
        failure(error, statusCode)
        completion(nil)
    }
    return request
}
}
