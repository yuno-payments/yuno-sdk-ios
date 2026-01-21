Pod::Spec.new do |s|
  s.name             = 'YunoSDK'
  s.version          = '2.10.1'
  s.summary          = 'A short description of YunoSDK.'

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

  s.author           = { 'Romel' => 'romel@y.uno' }
  s.source           = { :http => 'https://github.com/yuno-payments/yuno-sdk-ios/releases/download/' + s.version.to_s + '/YunoSDK.xcframework.zip' }

  s.ios.deployment_target = '13.0'
  s.swift_version         = '5.4'
  s.platform              = :ios, '13.0'

  s.requires_arc          = true


  s.vendored_frameworks = 'YunoSDK.xcframework'
  
  s.resource_bundles = {
    'YunoSDK_Resources' => [
      'YunoSDK.xcframework/Assets/**/*.xcassets',
      'YunoSDK.xcframework/Assets/Localization/*.lproj',
      'YunoSDK.xcframework/Assets/**/*.{storyboard,xib,json,ttf}'
    ]
  }

  s.frameworks = 'UIKit', 'Combine', 'Foundation'

  s.pod_target_xcconfig = { 
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES',
    'DEFINES_MODULE' => 'YES',
    'OTHER_LDFLAGS' => '-framework "YunoSDK"'
  }

  s.user_target_xcconfig = { 
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "${PODS_XCFRAMEWORKS_BUILD_DIR}/YunoSDK"'
  }

end