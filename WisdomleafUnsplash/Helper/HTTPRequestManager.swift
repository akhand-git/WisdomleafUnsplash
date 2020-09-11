//
//  HTTPRequestManager.swift
//  WisdomleafUnsplash
//
//  Created by Akhand on 11/09/20.
//  Copyright © 2020 Akhand. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import SwiftyJSON

/**
 Three HTTP methods (get,) are available, along with upload.
 
 Each method accepts following arguments:
 
 - url: This can be either a full URL or just a path in case a preset is available
 - (optional) params: This is the data sent with the request. Sent as query params in case of a GET request; sent as part of body in case of post and patch
 - (optional) preset: See HTTPManagerPreset class for available presets. Each preset will have default parameters. If you provide own parameters or headers, them will take precedence.
 - (optional) headers: Custom HTTP headers
 - (optional) encoding: Defaults to JSON. Most APIs expect JSON, while some expect Form URL encoded parameters
 - (optional) success: You can supply a success block. This will receive success response in case HTTP code is in range 200-299
 - (optional) failure: You can supply a failure block. This will receive error object in case HTTP code is NOT in range 200-299
 
 Upload function accepts either data or file. It has progress, success and failure callbacks.
 **/

class HTTPRequestManager: NSObject {
    var request: Request?
    
    static var getURLEncoding: URLEncoding {
        return URLEncoding(destination: .methodDependent, arrayEncoding: .noBrackets, boolEncoding: .literal)
    }
    
    static var getJSONEncoding: JSONEncoding {
        return JSONEncoding.default
    }
    
    func get(_ url: String, params: [String: Any]? = nil, preset: HTTPRequestPreset? = nil, headers: [String: String]? = nil, completionQueue: DispatchQueue? = nil, success: ((Data?) -> Void)? = nil, failure: ((Error?, Int) -> Void)? = nil) {
        requestToURL(url, method: .get, params: params, preset: preset, headers: headers, encoding: URLEncoding(),completionQueue: completionQueue, success: success, failure: failure)
    }
    

    
    /**
     We loop through user supplied parameters and add it to preset params.
     Existing ones will be overriden, while new ones are added
     **/
    fileprivate func mergeWithPreset(_ passedPresetParams: [String: Any]?, userParams: [String: Any]? = nil) -> [String: Any]? {
        guard let `passedPresetParams` = passedPresetParams else {
            return userParams
        }
        var presetParams = passedPresetParams
        if let userParamsUnwrappped = userParams {
            for (k, v) in userParamsUnwrappped {
                presetParams[k] = v
            }
        }
        return presetParams
    }
    
    // swiftlint:disable function_parameter_count
    private func requestToURL( _ url: String, method: HTTPMethod, params: [String: Any]?, preset: HTTPRequestPreset?, headers: [String: String]?, encoding: ParameterEncoding?, completionQueue: DispatchQueue?, success: ((Data?) -> Void)?, failure: ((Error?, Int) -> Void)?) {
        
        request = createRequest(url, method: method, params: params, preset: preset, headers: headers, encoding: encoding)
        
        (request as? DataRequest)?.validate().responseData(queue: completionQueue, completionHandler: { (response) in
            switch response.result {
            case .success(let val):
                success?(response.value)
            case .failure(let err):
                //Record non fatal here
                failure?(response.error, response.response?.statusCode ?? -1)
            }
        })
    }
    
    private func createRequest(_ passedURL: String, method: HTTPMethod, params passedParams: [String: Any]? = nil, preset: HTTPRequestPreset? = nil, headers passedHeaders: [String: String]? = nil, encoding passedEncoding: ParameterEncoding?) -> DataRequest {
        
        var url = passedURL
        var params = passedParams
        var headers = passedHeaders
        var encoding: ParameterEncoding? = passedEncoding
        // If preset is present, we need to merge our params with those in preset.
        if let presetUnwrapped = preset {
            params = mergeWithPreset(presetUnwrapped.params, userParams: params)
            headers = mergeWithPreset(presetUnwrapped.headers, userParams: headers) as? [String: String]
            url = presetUnwrapped.baseUrl + url
            // If user didn't supply encoding, use the one from preset
            if encoding == nil {
                encoding = presetUnwrapped.parameterEncoding
            }
        }
        
        // This either means preset was not selected, or preset somehow gave nil encoding.
        // We just set the encoding to JSON, which is used in almost all API calls.
        if encoding == nil {
            encoding = JSONEncoding(options: [ .prettyPrinted])
        }
        
        // Creating request!
        let alamofireConfig = AlamofireConfigurator.sharedInstance
        let request = alamofireConfig.manager.request(url, method: method, parameters: params, encoding: encoding!, cachePolicy: .reloadIgnoringCacheData, headers: headers)
        return request
    }
}

extension HTTPRequestManager {
    func cancel() {
        request?.cancel()
    }
}

fileprivate class AlamofireConfigurator {
    static let sharedInstance: AlamofireConfigurator = AlamofireConfigurator()
    let manager: SessionManager = {
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultHeaders["Accept-Language"] = nil
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        //configuration.timeoutIntervalForResource = PractoConstants.kTimeIntervalOneDay //Secs in day
        configuration.timeoutIntervalForRequest = 30.0 //Secs
        let manager = Alamofire.SessionManager(configuration: configuration)
        manager.startRequestsImmediately = true
        return manager
    }()
}

extension SessionManager {
    @discardableResult
    open func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        cachePolicy: URLRequest.CachePolicy = .reloadIgnoringCacheData,
        headers: HTTPHeaders? = nil)
        -> DataRequest
    {
        var originalRequest: URLRequest?
        
        do {
            originalRequest = try URLRequest(url: url.asURL(), cachePolicy: cachePolicy, timeoutInterval: 30.0)
            originalRequest?.httpMethod = method.rawValue
            
            if let headers = headers {
                for (headerField, headerValue) in headers {
                    originalRequest?.setValue(headerValue, forHTTPHeaderField: headerField)
                }
            }
            let encodedURLRequest = try encoding.encode(originalRequest!, with: parameters)
            return request(encodedURLRequest)
        } catch _ {
            return request(url)
        }
    }
}
