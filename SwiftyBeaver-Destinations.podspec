Pod::Spec.new do |s|
  s.name             = 'SwiftyBeaver-Destinations'
  s.version          = '1.0.0'
  s.summary          = 'Additionals destinations (LogEntries, Logmatic) and utilities for SwiftyBeaver.'

  s.homepage         = 'https://github.com/smartnsoft/SwiftyBeaver-Destinations'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Smart&Soft' => 'contact@smartnsoft.com' }
  s.source           = { :git => 'https://github.com/smartnsoft/SwiftyBeaver-Destinations.git', :tag => s.version.to_s }

  s.default_subspec  = 'Core'
  s.ios.deployment_target = '9.0'

  s.subspec 'Core' do |ss|
    ss.source_files = 'SwiftyBeaver-Destinations/Classes/Utils/*.{swift,h,m}'
    ss.dependency 'SwiftyBeaver', '~> 1.5'
  end

  s.subspec 'LogEntries' do |ss|
    ss.source_files = 'SwiftyBeaver-Destinations/Classes/LogEntries/**/*.{swift,h,m}'
    ss.dependency 'SwiftyBeaver-Destinations/Core'
    ss.dependency 'iOSLogEntries', '~> 1.2'
  end

  s.subspec 'Logmatic' do |ss|
    ss.source_files = 'SwiftyBeaver-Destinations/Classes/Logmatic/**/*.{swift,h,m}'
    ss.dependency 'SwiftyBeaver-Destinations/Core'
    ss.dependency 'Logmatic', '~> 1.0'
  end

end
