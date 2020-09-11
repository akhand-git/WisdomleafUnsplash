//
//  UnsplashApiPreset.swift
//  WisdomleafUnsplash
//
//  Created by Akhand on 11/09/20.
//  Copyright © 2020 Akhand. All rights reserved.
//

import Foundation

class UnsplashApiPreset: HTTPRequestPreset {
    
  @objc static var kBoardAuthToken: [String: String] {
        return ["Authorization": "Bearer:"]
    }
    static var getReportApi: HTTPRequestPreset {
        var headers: [String:String] = [String: String]()
        headers +& [kContentTypeJson, kBoardAuthToken]
        return HTTPRequestPreset(headers: headers, params: nil, encoding: HTTPRequestManager.getURLEncoding, baseUrl: APIConstants.baseURL)
    }
    
}
