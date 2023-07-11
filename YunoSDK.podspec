Pod::Spec.new do |s|
  s.name             = 'YunoSDK'
  s.version          = '40.40.40'
  s.summary          = 'A short description of YunoSDK.'

  s.description      = <<-DESC

  A fast checkout that integrates your company
  to the payments and fraud ecosystem.

  Checkout + Routing + Reconciliations + Alternative Payment Methods

                       DESC

  s.homepage         = 'https://www.y.uno/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jonathan Pacheco' => 'jonathan.pacheco@y.uno.com' }
  s.source           = { :http => 'https://github.com/yuno-payments/yuno-sdk-ios/releases/download/' + s.version.to_s + '/YunoSDK.xcframework.zip' }

  s.ios.deployment_target = '13.0'
  s.swift_version         = '5.4'
  s.platform              = :ios, '13.0'

  s.requires_arc          = true

  s.prepare_command = <<-CMD
    curl -L -o OpenpayKit.xcframework.zip https://github.com/open-pay/openpay-swift-ios/releases/download/3.1.0/OpenpayKit.xcframework.zip && \
    unzip OpenpayKit.xcframework.zip && \
    rm OpenpayKit.xcframework.zip
    CMD

  s.vendored_frameworks = 'YunoSDK.xcframework', 'OpenpayKit.xcframework'
  
  s.resource_bundles = {
        'Resources' => [
            'YunoSDK.xcframework/Assets/**/*.xcassets',
            'YunoSDK.xcframework/Assets/Localization/*.lproj',
            'YunoSDK.xcframework/Assets/**/*.{storyboard,xib,json}'
        ]
    }

  s.frameworks = 'UIKit'
  s.frameworks = 'Combine'
  s.xcconfig = { 'SWIFT_INCLUDE_PATHS' => ['${PODS_XCFRAMEWORKS_BUILD_DIR}/YunoSDK'] }
  s.pod_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }
end
