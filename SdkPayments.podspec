Pod::Spec.new do |s|
  s.name             = 'SdkPayments'
  s.version          = '3.0.0-alpha.1'
  s.summary          = 'Yuno Payments SDK — a fast, secure checkout for the Yuno payments and fraud ecosystem.'

  s.description      = <<-DESC

  A fast checkout that integrates your company
  to the payments and fraud ecosystem.

  Checkout + Routing + Reconciliations + Alternative Payment Methods

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

  s.author           = { 'Jonathan Pacheco' => 'jonathan.pacheco@y.uno.com' }
  s.source           = { :http => 'https://github.com/yuno-payments/yuno-sdk-ios/releases/download/' + s.version.to_s + '/SdkPayments.xcframework.zip' }

  s.ios.deployment_target = '14.0'
  s.swift_version         = '5.4'
  s.platform              = :ios, '14.0'
  s.static_framework      = true

  s.requires_arc          = true

  s.module_name           = 'SdkPayments'
  s.vendored_frameworks   = 'SdkPayments.xcframework'
  
  s.resource_bundles = {
        'Resources' => [
            'SdkPayments.xcframework/Assets/**/*.xcassets',
            'SdkPayments.xcframework/Assets/Localization/*.lproj',
            'SdkPayments.xcframework/Assets/**/*.{storyboard,xib,json,ttf}'
        ]
    }

  s.frameworks = 'UIKit', 'Combine'
  s.xcconfig = { 'SWIFT_INCLUDE_PATHS' => ['${PODS_XCFRAMEWORKS_BUILD_DIR}/SdkPayments'] }
  s.pod_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }
end
