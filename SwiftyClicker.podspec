#
# Be sure to run `pod lib lint SwiftyClicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyClicker'
  s.version          = '0.1.0'
  s.summary          = 'SwiftyClicker is multi-clicker for iOS'

  s.homepage         = 'https://github.com/alperengezgin/SwiftyClicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alperen Polat GEZGIN' => 'alperengezgin@gmail.com' }
  s.source           = { :git => 'https://github.com/alperengezgin/SwiftyClicker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/alperengezgin'

  s.ios.deployment_target = '13.0'

  s.source_files = 'SwiftyClicker/Classes/**/*'
  
   s.resource_bundles = {
     'SwiftyClicker' => ['SwiftyClicker/Assets/*.{png,json,xcassets,xib}']
   }

   s.frameworks = 'UIKit', 'WebKit'
   s.dependency 'SwiftyUserDefaults'
end
