
Pod::Spec.new do |s|
  s.name         = "Repose"
  s.version      = "0.0.1"
  s.summary      = "A lightweight extension of AFNetworking for REST."
  s.homepage     = "https://github.com/vilea/Repose"
 
  s.license      = { :type => 'Custom', :file => 'README.markdown' }

  s.author       = { "Junior Bontognali" => "junior.bontognali@vilea.ch" }
  s.source       = { :git => "https://github.com/vilea/Repose.git", :tag => "0.0.1" }

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'

  s.source_files = 'Repose/Repose/*.{h,m}'
  s.exclude_files = 'Repose/Example'

  s.public_header_files = 'Repose/Repose/**/*.h'
  
  s.requires_arc = true

  s.dependency 'AFNetworking'
  s.dependency 'AFOAuth2Client'
end
