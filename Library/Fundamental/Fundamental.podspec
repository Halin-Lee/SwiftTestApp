#
# Be sure to run `pod lib lint Fundamental.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Fundamental'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Fundamental.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/d.halin.lee@gmail.com/Fundamental'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.author           = { 'd.halin.lee@gmail.com' => 'd.halin.lee@gmail.com' }
  s.source           = { :git => 'https://github.com/d.halin.lee@gmail.com/Fundamental.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Fundamental/Classes/**/*'

  # s.resource_bundles = {
  #   'Fundamental' => ['Fundamental/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  #xml解析，ModuleLoader使用
  s.dependency 'SWXMLHash'
  #网络库
  s.dependency 'Alamofire'
  s.dependency 'ReactiveCocoa', '~> 5.0.0'


end
