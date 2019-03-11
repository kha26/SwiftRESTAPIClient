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
    
    public func send<T>(_ request: T, reponseBlock block: ((APIResponse<T.Response>) -> Void)?) -> DataRequest?
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
            let request = Alamofire.request(url, method: request.method.http, parameters: parameters, headers: headers)
                .validate(statusCode: configuration.minStatusCode...configuration.maxStatusCode)
                .responseData { (response) in
                    let callbackResponse: APIResponse<T.Response>
                    switch response.result {
                    case .success(let data):
                        if let statusCode = response.response?.statusCode,
                            statusCode >= configuration.minErrorCode {
                            callbackResponse = .failure(APIError.serverError(JSONString: String(data: data, encoding: .utf8) ?? "Unkown Error"));
                        } else {
                            do {
                                let decoder = JSONDecoder();
                                decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601;
                                let result = try decoder.decode(T.Response.self, from: data);
                                callbackResponse = .success(result);
                            } catch {
                                callbackResponse = .failure(error);
                            }
                        }
                    case .failure(let error):
                        callbackResponse = .failure(error)
                    }
                    request.callback(response: callbackResponse);
                    block?(callbackResponse);
            }
            return request;
    }
}


protocol APIClientProtocol {
    
    /// Configuration for the client
    var configuration: APIConfiguration? { get set }
    
    /// Send a request to the server
    func send<T: APIRequest>( _ request: T, reponseBlock block: ((APIResponse<T.Response>) -> Void)?) -> DataRequest?
}

public enum APIResponse<Value> {
    case failure(Error);
    case success(Value);
}
