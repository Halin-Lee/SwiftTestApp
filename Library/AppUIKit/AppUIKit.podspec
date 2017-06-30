#
# Be sure to run `pod lib lint AppUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppUIKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of AppUIKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/d.halin.lee@gmail.com/AppUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'd.halin.lee@gmail.com' => 'd.halin.lee@gmail.com' }
  s.source           = { :git => 'https://github.com/d.halin.lee@gmail.com/AppUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AppUIKit/Classes/**/*'
  
  s.resource_bundles = {
    'HLUIKit' => ['HLUIKit/Assets/*.png']
  }

  s.dependency 'Fundamental'
  s.dependency 'SnapKit'
  s.dependency 'MaterialComponents'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
