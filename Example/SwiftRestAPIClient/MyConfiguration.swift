//
//  MyConfiguration.swift
//  SwiftRestAPIClient_Example
//
//  Created by Kemal Hasan Atay on 7/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import SwiftRestAPIClient

class MyConfiguration: APIConfiguration {
    var minStatusCode: Int = 200
    
    var maxStatusCode: Int = 600
    
    var baseUrl: String = "https://127.0.0.1:8081"
    
    var headers: [String: String] {
        return [:]
    }
}
