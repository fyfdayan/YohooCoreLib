
Pod::Spec.new do |s|
  s.name             = 'YohooCoreLib'
  s.version          = '0.1.0'
  s.summary          = 'YohooCoreLib'

  s.description      = 'YohooCoreLib for yohoo'

  s.homepage         = 'https://github.com/fyfdayan/YohooCoreLib.git'  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '傅雁锋' => 'bird@corplus.net' }
  s.source           = { :git => 'https://github.com/fyfdayan/YohooCoreLib.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'YohooCoreLib/Classes/**/*'

  s.public_header_files = 'YohooCoreLib/Classes/**/*.h'
  s.dependency 'MJExtension'
  s.dependency 'Realm'
  s.dependency 'FMDB'
  s.dependency 'MBProgressHUD'
  s.dependency 'Unirest'
  s.dependency 'Realm+JSON' 
  
end
