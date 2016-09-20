workspace 'MVC_Demo'
project 'MVC_Demo.xcodeproj'
platform :ios, '9.3'

use_frameworks!

def testing_pods
  pod 'Quick', '~> 0.9.2'
  pod 'Nimble', '~> 4.0.1'
  pod 'OHHTTPStubs'
  pod 'OHHTTPStubs/Swift'
end

def networking_pods 
  pod 'Alamofire'
end

pod 'SwiftyJSON'

target 'MVC_Demo' do
  networking_pods
end

target 'MVC_DemoTests' do
  networking_pods
  testing_pods
end
