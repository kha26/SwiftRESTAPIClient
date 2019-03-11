#
# Be sure to run `pod lib lint SwiftRestAPIClient.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftRestAPIClient'
  s.version          = '2.0.4'
  s.summary          = 'A REST API client for Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SwiftRestAPIClient provides a basic structure for creating a client API to connect to a REST backend.
                       DESC

  s.homepage         = 'https://github.com/kha26/SwiftRESTAPIClient'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kha26' => 'kha26@cornell.edu' }
  s.source           = { :git => 'https://github.com/kha26/SwiftRESTAPIClient.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.0'

  s.source_files = 'Classes/**/*.swift'
  
  # s.resource_bundles = {
  #   'SwiftRestAPIClient' => ['SwiftRestAPIClient/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire'
end
