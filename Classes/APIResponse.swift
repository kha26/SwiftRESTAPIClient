//
//  APIResponse.swift
//  Pods-SwiftRestAPIClient_Example
//
//  Created by Kemal Hasan Atay on 7/8/18.
//

protocol APIResponse {
    
    /// Initialize a response
    init()
    
    /// Type of result that this response returns
    associatedtype ResultType = AnyObject
    
    /// The result that will be returned for this response
    var result: ResultType? { get set }
    
    /// The error
    var error: Error? { get set }
    
    /// Parse the result JSON String
    func gotData(JSONString: String)
    
    /// Parse the error JSON String
    mutating func gotError(JSONString: String)
}

