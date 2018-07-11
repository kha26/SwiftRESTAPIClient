# SwiftRestAPIClient

[![CI Status](https://img.shields.io/travis/kha26/SwiftRestAPIClient.svg?style=flat)](https://travis-ci.org/kha26/SwiftRestAPIClient)
[![Version](https://img.shields.io/cocoapods/v/SwiftRestAPIClient.svg?style=flat)](https://cocoapods.org/pods/SwiftRestAPIClient)
[![License](https://img.shields.io/cocoapods/l/SwiftRestAPIClient.svg?style=flat)](https://cocoapods.org/pods/SwiftRestAPIClient)
[![Platform](https://img.shields.io/cocoapods/p/SwiftRestAPIClient.svg?style=flat)](https://cocoapods.org/pods/SwiftRestAPIClient)

SwiftRestAPIClient is a framework written in Swift that makes it easy for you to build a Rest API client for you application.

- [Features] (#features)
- [The Basics] (#example-usage)

# Features
- Base skeleton system for a client
- Generic types on requests and responses
- Error handling
- Configuration of the client

# Example Usage
First you need to configure the API Client by implementing the ```APIConfiguration``` protocol which includes the following:
```swift
/// Base URL of the API
var baseUrl: String { get }

/// The default HTTP Headers that will be sent for every request
var headers: [String: String] { get }

// The minimum acceptable status code for the backend
var minStatusCode: Int { get }

// The maximum acceptable status code for the backend
var maxStatusCode: Int { get }
```

For example:
```class MyConfiguration: APIConfiguration```


Then, in ```AppDelegate.swift```, set the configuration of the client:
```swift
import SwiftRestAPIClient

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: 
[UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    APIClient.shared.configuration = MyConfiguration()
    return true
}
```

Now the configuration has been set, its time to set the requests. This is pretty straight forward, you just need to understand how the APIClient, APIRequest and APIResponse work together. The client sends a request to the server and returns a response that is declared in the request. The APIClient is already a class that's working so you don't need to subclass that. Let's think of an example backend application that has users and the users can create posts and comments. We could have endpoints like these:
GET /posts
POST /posts
POST /users/login

Before implementing the requests we need to figure out what kind of responses we want to receive. Usually a request returns one object or an array of objects. I usually create the following two classes for responses: ObjectResponse and ArrayResponse. Let's assume you use a base class for your objects in your API: MyAPIObject. Then we can code ObjectResponse like this:

```swift
class ObjectResponse<T>: APIResponse where T: MyAPIObject {

    required init() {}

    typealias ResultType = T

    var result: ResultType?

    var error: APIError?

    var success: Bool = false

    func gotData(JSONString: String) {
        // Convert the JSONString into MyAPIObject
        // I use the ObjectMapper pod by Hearst-DD, so my conversion goes like this
        if let result = Mapper<T>().map(JSONString: JSONString) {
            self.success = true
            self.result = result
        } else {
            self.success = false
            self.error = APIError.jsonConversionFailed
        }
    }
    
    func gotError(JSONString: String) {
        // If the server sends some data as an error, you can
        // do the parsing here and set self.error
    }
}
```

The ArrayResponse is similar to ObjectResponse. Just use 
```swift
typealias ResultType = [T]
```
and you might want to change the ```gotData``` function as well. Now it's time to create the requests.

For a GET request like ```GET /posts?limit=5&offset=10 you can implement the ```APIRequest``` protocol in the following way:
```swift
class GetPostsRequest {
    typealias Response = ArrayResponse<Post>

    var resourceName: String {
        return "/posts"
    }

    var method: APIMethod {
        return .get
    }

    var parameters: [String: Any] = [:]
    
    init(limit: Int, offset: Int) {
        parameters["limit"] = limit
        parameters["offset"] = offset
    }
}
```

For a POST request like ```POST /posts/5/comments``` to create a comment object you can do the following:
```swift
class PostPostRequest {
    typealias Response = ObjectResponse<Comment>

    var resourceName: String {
        return "/post/\(postId)/comments"
    }

    var method: APIMethod {
        return .post
    }

    var parameters: [String: Any] = [:]
    
    var postId: Int
    
    init(post: Post) {
        self.postId = post.id
        parameters["message"] = post.message
        parameters["createdBy"] = post.user.id
    }
}
```

APIRequest also has two more features: headers and callback. For example if you're sending a login request as a POST, you might want to add a Basic Auth header and save the resulting data (e.g. a token) that you get from the server. Implementing this is easy:

```swift
class UserLoginRequest {
    
    private var username: String
    private var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    var headers: HTTPHeaders {
        var headers: HTTPHeaders = [:]
        if let authorizationHeader = Request.authorizationHeader(user: username, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        return headers
    }
    
    func callback(item: UserLoginRequest.Response) {
        // item.result is the response object
        // here you can save it like
        // this function is called after the request is completed
        Keychain.save(item.result)
    }
}
```

Finally, calling these requests is really simple:
```swift
let request = APIClient.shared.send(GetPostsRequest(limit: 10, offset: 5), objectBlock: { (response) in
    if (reponse.success) {
        // do something with response.result
        // you will see that response.result is the type that you want
    } else {
        // handle response.error
    }
})
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SwiftRestAPIClient is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftRestAPIClient'
```

## Author

kha26, kha26@cornell.edu

## License

SwiftRestAPIClient is available under the MIT license. See the LICENSE file for more info.
