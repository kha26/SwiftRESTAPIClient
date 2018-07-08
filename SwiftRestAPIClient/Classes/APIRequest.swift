//
//  APIRequest.swift
//  Pods-SwiftRestAPIClient_Example
//
//  Created by Kemal Hasan Atay on 7/8/18.
//

import Alamofire

protocol APIRequest {
    
    /// Type of response that will be returned from this request
    associatedtype Response: APIResponse
    
    /// The resourse name, aka. the route to access the resource
    var resourceName: String { get }
    
    /// The REST API method that will be used
    var method: APIMethod { get }
    
    /// The parameters that will be sent with the request
    var parameters: [String: Any] { get set }
    
    /// HTTP Headers
    var headers: HTTPHeaders { get }
    
    /// Callback for custom action
    func callback(item: Response)
    
}

extension APIRequest {
    
    var headers: HTTPHeaders {
        return [:]
    }
    
    func callback(item: Response) {
        
    }
    
}

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    
    var http: HTTPMethod {
        switch self {
        case APIMethod.get:
            return HTTPMethod.get
        case APIMethod.post:
            return HTTPMethod.post
        case APIMethod.delete:
            return HTTPMethod.delete
        case APIMethod.put:
            return HTTPMethod.put
        }
    }
}
