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
    
    public required init() {}
    
    public typealias ResultType = T
    
    public var result: ResultType?
    
    public var error: Error?
    
    public var success: Bool = false
    
    public func gotData(JSONString: String) {
        if let data = JSONString.data(using: .utf8) {
            do {
                let decoder = JSONDecoder();
                decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601
                let result = try decoder.decode(ResultType.self, from: data)
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
                let decoder = JSONDecoder();
                decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601
                let result = try decoder.decode(ResultType.self, from: data)
                self.success = true;
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

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime])
}

extension JSONDecoder.DateDecodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = Formatter.iso8601.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Invalid date: " + string)
        }
        return date
    }
}
