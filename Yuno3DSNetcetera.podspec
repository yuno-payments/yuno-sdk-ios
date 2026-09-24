Pod::Spec.new do |s|
  s.name             = 'Yuno3DSNetcetera'
  s.version          = '3.0.0'
  s.summary          = 'Netcetera 3DS SDK integration for the Yuno iOS SDK.'

  s.description      = <<-DESC

  Optional 3DS module for the Yuno iOS SDK based on Netcetera's ThreeDS_SDK.
  Add this pod next to YunoSDK when you need to perform 3-D Secure
  authentication challenges in-app, and register the provider once before
  starting a payment flow.

                       DESC

  s.homepage         = 'https://www.y.uno/'
  s.license          = {
  :type => 'MIT',
  :text => <<-LICENSE
                  Copyright (c) 2022 Yuno Inc

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  LICENSE
}

  s.author           = { 'Yuno' => 'sdk@y.uno' }
  s.source           = { :http => 'https://github.com/yuno-payments/yuno-sdk-ios/releases/download/netcetera-' + s.version.to_s + '/Yuno3DSNetcetera_cocoapods.zip' }

  s.ios.deployment_target = '14.0'
  s.swift_version         = '5.7'
  s.platform              = :ios, '14.0'
  s.static_framework      = true

  s.requires_arc          = true

  s.vendored_frameworks = 'Yuno3DSNetcetera.xcframework', 'ThreeDS_SDK.xcframework'

  s.frameworks = 'UIKit', 'Combine'
  s.pod_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }

  s.dependency 'YunoSDK', '~> 2.25'
end
