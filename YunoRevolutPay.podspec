Pod::Spec.new do |s|
  s.name             = 'YunoRevolutPay'
  s.version          = '1.0.0'
  s.summary          = 'Revolut Pay provider module for the Yuno iOS SDK.'

  s.description      = <<-DESC

  Adds native Revolut Pay support to the Yuno iOS SDK on top of Revolut's
  official RevolutPayments SDK. Add this pod next to YunoSDK and register the
  provider once before starting a payment flow.

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
  s.source           = { :http => 'https://github.com/yuno-payments/yuno-sdk-ios/releases/download/revolutpay-' + s.version.to_s + '/YunoRevolutPay.xcframework.zip' }

  s.ios.deployment_target = '15.0'
  s.swift_version         = '5.7'
  s.platform              = :ios, '15.0'
  s.static_framework      = true

  s.requires_arc          = true

  s.vendored_frameworks = 'YunoRevolutPay.xcframework'

  s.dependency 'YunoSDK', '~> 2.25'
  s.dependency 'RevolutPayments/RevolutPay', '~> 3.16.0'
  s.dependency 'lottie-ios', '>= 4.4.1', '< 4.6'
end
