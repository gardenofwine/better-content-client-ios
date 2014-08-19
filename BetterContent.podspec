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
  s.version          = "0.1.0"
  s.summary          = "A short description of BetterContent."
  s.description      = <<-DESC
                       An optional longer description of BetterContent

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/<GITHUB_USERNAME>/BetterContent"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "gardenofwine" => "gardenofwine@gmail.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/BetterContent.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resources = 'Pod/Assets/*.png'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.subspec 'Core' do |ss|
    ss.source_files = 'Pod/Classes/Core', 'BetterContent/Core/*.{h,m}'
  end

  s.subspec 'Scanner' do |ss|
    ss.source_files = 'Pod/Classes/Scanner', 'BetterContent/Scanner/*.{h,m}'
  end

end
