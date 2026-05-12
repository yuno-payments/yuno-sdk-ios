Pod::Spec.new do |s|
  s.name             = 'YunoSDK3DSNetcetera'
  s.version          = '2.17.0-RC.2'
  s.summary          = 'Netcetera 3DS provider for YunoSDK.'

  s.description      = <<-DESC
  Optional 3DS provider that plugs Netcetera's ThreeDS_SDK into YunoSDK.
  Built as a static framework (matches the static YunoSDK pod). Merchants
  must call `Yuno3DSNetcetera.register()` once at app startup — this pod
  ships without the ObjC `+load` bootstrap that the SPM (dynamic) variant
  uses for auto-registration.
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
  s.source           = { :http => 'https://github.com/yuno-payments/yuno-sdk-ios/releases/download/' + s.version.to_s + '/YunoSDK3DSNetcetera.zip' }

  s.ios.deployment_target = '14.0'
  s.swift_version         = '5.7'
  s.platform              = :ios, '14.0'
  s.static_framework      = true

  s.requires_arc          = true

  s.vendored_frameworks   = ['Yuno3DSNetcetera.xcframework', 'ThreeDS_SDK.xcframework']

  # YunoSDK is NOT declared as a dependency on purpose: this pod is
  # built against YunoSDK 2.17.0+ but the merchant's Podfile is the
  # single source of truth for the YunoSDK version. They must add
  # `pod 'YunoSDK'` themselves. If YunoSDK is missing or older than
  # 2.17.0, linking will fail with undefined symbols
  # (`_OBJC_CLASS_$_YunoThreeDSRegistry`, etc.).

  s.frameworks = 'UIKit', 'Combine'

  s.pod_target_xcconfig = {
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES'
  }
end
