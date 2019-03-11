//
//  GetWorkouts.swift
//  SwiftRestAPIClient_Example
//
//  Created by Kemal Hasan Atay on 3/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import SwiftRestAPIClient

class GetWorkouts: APIRequest {
    typealias Response = [Workout]
    
    var resourceName: String = "api/workout"
    
    var method: APIMethod = .get
    
    var parameters: [String : Any] = [:]
    
}

