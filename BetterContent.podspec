#
# Be sure to run `pod lib lint BetterContent.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BetterContent"
  s.version          = "0.0.2"
  s.summary          = "Allows for real time app content modifications"
  s.description      = <<-DESC
                       When developing web apps, one can open FireBug and make changes to texts and images on the spot, immediately seeing the effect. When developing mobile applications, each change requires code modification, recompile and a reinstall. This makes the development cycle of mobile application longer and more tedious. 

                       When installing the BetterContent pod, you can edit your application in runtime via a browser interface. Run your application and open http://bettercontent.herokuapp.com to edit its content.
                       DESC
  s.homepage         = "http://bettercontent.herokuapp.com"
  s.license          = 'MIT'
  s.author           = { "gardenofwine" => "gardenofwine@gmail.com" }
  s.source           = { :git => "https://github.com/gardenofwine/better-content-client-ios.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/gardenofwine'
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'MAZeroingWeakRef'
  s.dependency 'BlocksKit'
  s.dependency 'SocketRocket'
  s.dependency 'UIImage-ResizeMagick'

end
