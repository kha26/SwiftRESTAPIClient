//
//  APIResponse.swift
//  Pods-SwiftRestAPIClient_Example
//
//  Created by Kemal Hasan Atay on 7/8/18.
//

public protocol APIResponse {
    
    /// Initialize a response
    init()
    
    /// Type of result that this response returns
    associatedtype ResultType = AnyObject
    
    /// The result that will be returned for this response
    var result: ResultType? { get set }
    
    /// The error
    var error: Error? { get set }

    // Indicates if the request was resulted in success
    var success: Bool { get set }
    
    /// Parse the result JSON String
    func gotData(JSONString: String)
}

public class ObjectResponse<T>: APIResponse where T: Codable {
    
    required public init() {}
    
    public typealias ResultType = T
    
    public var result: ResultType?
    
    public var error: Error?
    
    public var success: Bool = false
    
    public func gotData(JSONString: String) {
        if let data = JSONString.data(using: .utf8) {
            do {
                let result = try JSONDecoder().decode(ResultType.self, from: data)
                self.result = result
            } catch {
                self.success = false
                self.error = APIError.jsonConversionFailed
            }
        } else {
            self.success = false
            self.error = APIError.jsonConversionFailed
        }
    }
}

public class ArrayResponse<T>: APIResponse where T: Codable {
    
    public required init() {}
    
    public typealias ResultType = [T]
    
    public var result: ResultType?
    
    public var error: Error?
    
    public var success: Bool = false
    
    public func gotData(JSONString: String) {
        if let data = JSONString.data(using: .utf8) {
            do {
                let result = try JSONDecoder().decode(ResultType.self, from: data)
                self.result = result
            } catch {
                self.success = false
                self.error = APIError.jsonConversionFailed
            }
        } else {
            self.success = false
            self.error = APIError.jsonConversionFailed
        }
    }
}
