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
var headers: HTTPHeaders { get }
```

For example:
```class MyConfiguration: APIConfiguration```


Then, in ```AppDelegate.swift```, set the configuration of the client:
```
import SwiftAPIC

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
