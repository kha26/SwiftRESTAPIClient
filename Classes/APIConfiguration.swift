//
//  APIConfiguration.swift
//  Pods-SwiftRestAPIClient_Example
//
//  Created by Kemal Hasan Atay on 7/8/18.
//

public protocol APIConfiguration {
    
    /// Base URL of the API
    var baseUrl: String { get }
    
    /// The default HTTP Headers that will be sent for every request
    var headers: [String: String] { get }
    
    // The minimum acceptable status code for the backend
    var minStatusCode: Int { get }
    
    // The maximum acceptable status code for the backend
    var maxStatusCode: Int { get }
    
}
