//
//  APIClient.swift
//  Pods-SwiftRestAPIClient_Example
//
//  Created by Kemal Hasan Atay on 7/8/18.
//

import Alamofire

public class APIClient: APIClientProtocol {
    
    public var configuration: APIConfiguration?
    
    public static var shared: APIClient = APIClient()
    
    public func send<T>(_ request: T, objectBlock block: ResultCallback<T.Response>?) -> DataRequest?
        where T: APIRequest {
            guard let configuration = configuration else {
                fatalError("Configuration not set for the APIClient.")
            }
            var headers = configuration.headers
            for (key, value) in request.headers {
                headers[key] = value
            }
            
            let parameters: Parameters = request.parameters
            let url = configuration.baseUrl + request.resourceName
            let alamoReq = Alamofire.request(url, method: request.method.http, parameters: parameters, headers: headers)
            alamoReq.validate(statusCode: configuration.minStatusCode...configuration.maxStatusCode)
                .responseString { (response) in
                var apiResponse = T.Response()
                switch response.result {
                case .success(let JSONString):
                    if let code = response.response?.statusCode {
                        if code < 400 {
                            apiResponse.gotData(JSONString: JSONString)
                        } else {
                            apiResponse.error = APIError.serverError(JSONString: JSONString)
                            apiResponse.success = false
                        }
                    } else {
                        apiResponse.error = APIError.serverUnknownError
                    }
                case .failure(let error):
                    apiResponse.error = error
                }
                request.callback(item: apiResponse)
                block?(apiResponse)
            }
            return alamoReq
    }
}

public typealias ResultCallback<Value> = (Value) -> Void

protocol APIClientProtocol {
    
    /// Configuration for the client
    var configuration: APIConfiguration? { get set }
    
    /// Send a request to the server
    func send<T: APIRequest>( _ request: T, objectBlock block: ResultCallback<T.Response>?) -> DataRequest?
}
