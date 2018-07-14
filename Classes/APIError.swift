//
//  APIError.swift
//  Pods-SwiftRestAPIClient_Example
//
//  Created by Kemal Hasan Atay on 7/8/18.
//

public enum APIError: Error {
    case jsonConversionFailed
    case serverUnknownError
    case serverError(JSONString: String)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .jsonConversionFailed:
            return NSLocalizedString("JSON Conversion failed", comment: "JSON Conversion Failed")
        case .serverUnknownError:
            return NSLocalizedString("There was an unknown error", comment: "Unknown server error")
        case .serverError(let JSONString):
            return NSLocalizedString("There was a server error. Data: \(JSONString)", comment: "Server error")
        }
    }
}
