Pod::Spec.new do |s|
  s.name             = 'YunoSDK'
  s.version          = '0.1.1'
  s.summary          = 'A short description of YunoSDK.'

  s.description      = <<-DESC

  A fast checkout that integrates your company
  to the payments and fraud ecosystem.

  Checkout + Routing + Reconciliations + Alternative Payment Methods

                       DESC

  s.homepage         = 'https://www.y.uno/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jonathan Pacheco' => 'jonathan.pacheco@y.uno.com' }
  s.source           = { :git => 'https://github.com/yuno-payments/yuno-sdk-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.swift_version         = '5.4'
  s.platform              = :ios, '12.0'

  s.requires_arc          = true

  s.vendored_frameworks = "YunoSDK.xcframework"
  
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  
  s.frameworks = 'UIKit'
  s.xcconfig = { 'SWIFT_INCLUDE_PATHS' => ['${PODS_XCFRAMEWORKS_BUILD_DIR}/YunoSDK'] }
end
