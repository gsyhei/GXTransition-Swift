#
#  Be sure to run `pod spec lint GXTransition-Swift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name          = "GXTransition-Swift"
  s.version       = "1.0.1"
  s.swift_version = "5.0"
  s.summary       = "iOS常用转场动画swift版本。(Commonly used transition animation in iOS.(including custom transition animation and swift own transition animation.)"
  s.homepage      = "https://github.com/gsyhei/GXTransition-Swift"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Gin" => "279694479@qq.com" }
  s.platform      = :ios, "9.0"
  s.source        = { :git => "https://github.com/gsyhei/GXTransition-Swift.git", :tag => "1.0.1" }
  s.requires_arc  = true
  s.source_files  = "GXTransition-Swift"
  s.frameworks    = "UIKit"

end
