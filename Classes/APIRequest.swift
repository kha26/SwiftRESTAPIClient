//
//  APIRequest.swift
//  Pods-SwiftRestAPIClient_Example
//
//  Created by Kemal Hasan Atay on 7/8/18.
//

import Alamofire

public protocol APIRequest {
    
    /// Type of response that will be returned from this request
    associatedtype Response: Decodable
    
    /// The resourse name, aka. the route to access the resource
    var resourceName: String { get }
    
    /// The REST API method that will be used
    var method: APIMethod { get }
    
    /// The parameters that will be sent with the request
    var parameters: [String: Any] { get set }
    
    /// HTTP Headers
    var headers: [String: String] { get }
    
    /// Callback for custom action
    func callback(response: APIResponse<Response>)
    
}

public extension APIRequest {
    
    var headers: [String: String] {
        return [:]
    }
    
    func callback(response: APIResponse<Response>) {}
}

public enum APIMethod: String {
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
