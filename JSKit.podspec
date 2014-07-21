Pod::Spec.new do |s|
  s.name         = 'JSKit'
  s.version      = '1.0'
  s.license      = 'MIT'
  s.summary      = 'JSKit is collection of framework for iOS.'
  s.homepage     = 'https://github.com/Jaesung-Jung/JSKit'
  s.author       = { 'Jaesung-Jung' => 'heyjerks@live.co.kr' }
  s.source       = { :git => 'https://github.com/Jaesung-Jung/JSKit.git', :tag => '1.0' }
  s.requires_arc = true

  s.platform     = :ios, '7.0'

  s.public_header_files = 'JSKit/*.h'
  s.source_files = 'JSKit/JSKit.h'

  s.library   = 'z'
end
