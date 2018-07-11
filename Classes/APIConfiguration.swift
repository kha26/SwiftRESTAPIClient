//
//  APIConfiguration.swift
//  Pods-SwiftRestAPIClient_Example
//
//  Created by Kemal Hasan Atay on 7/8/18.
//

import Alamofire

protocol APIConfiguration {
    
    /// Base URL of the API
    var baseUrl: String { get }
    
    /// The default HTTP Headers that will be sent for every request
    var headers: HTTPHeaders { get }
    
}
