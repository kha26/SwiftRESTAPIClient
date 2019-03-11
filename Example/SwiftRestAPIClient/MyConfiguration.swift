//
//  MyConfiguration.swift
//  SwiftRestAPIClient_Example
//
//  Created by Kemal Hasan Atay on 7/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import SwiftRestAPIClient

class MyConfiguration: APIConfiguration {
    var minErrorCode: Int = 400
    
    var minStatusCode: Int = 200
    
    var maxStatusCode: Int = 600
    
    var baseUrl: String = "http://127.0.0.1:3000/"
    
    var headers: [String: String] {
        return [:]
    }
}
