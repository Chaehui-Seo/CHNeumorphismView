# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CHNeumorphismView'
  s.version          = '1.0.0'
  s.summary          = 'Assistant for Neumorphism UI in iOS'
  
  # Set Swift version
  s.swift_version = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This library is an assistant of making neumorphism UI in iOS with UIKit.
                       DESC

  s.homepage         = 'https://github.com/Chaehui-Seo/CHNeumorphismView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chaehui-Seo' => 'sch0991@naver.com' }
  s.source           = { :git => 'https://github.com/Chaehui-Seo/CHNeumorphismView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'Sources/CHNeumorphismView/**/*'
  
  # s.resource_bundles = {
  #   'CHNeumorphismView' => ['CHNeumorphismView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
