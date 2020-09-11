//
//  HTTPRequestPreset.swift
//  WisdomleafUnsplash
//
//  Created by Akhand on 11/09/20.
//  Copyright © 2020 Akhand. All rights reserved.
//

import Foundation
import Alamofire

/**
 We have four presets as of now.

 Each preset has 4 properties:

 - headers: This is a dictionary of default HTTP headers to send with request
 - params: This is a dictionary of default textual data to send with request
 - parameterEncoding: Parameter encodings such as URL, JSON
 - baseUrl: This will be prepended to the path you provide

 As of now we have two base API URLs, which are set to staging server.
**/

extension HTTPRequestPreset {
   
    static var kTempAuthToken: [String: String] {
        return ["Authorization": ""]
    }
    
    static var kAcceptJSON: [String:String] {
        return ["Accept": "application/json"]
    }
    static var kContentTypeJson: [String:String] {
        return ["Content-Type": "application/json"]
    }
    static var kContentTypeURLEncoded: [String:String] {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }

}

infix operator +&
func +& (left: inout [String: String], right: [[String: String]?]) {
    for item in right {
        if let itemT = item {
            for (k, v) in itemT {
                left.updateValue(v, forKey: k)
            }
        }
    }
}

class HTTPRequestPreset {

    var headers: [String: String]?
    var params: [String: Any]?
    var parameterEncoding: ParameterEncoding
    var baseUrl: String

    init(headers: [String: String]?=[String: String](), params: [String: Any]? = [String: Any](), encoding: ParameterEncoding, baseUrl: String = "") {
        self.headers = headers
        self.params = params
        self.parameterEncoding = encoding
        self.baseUrl = baseUrl
    }



}
