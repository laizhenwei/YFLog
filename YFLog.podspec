Pod::Spec.new do |s|
  s.name             = 'YFLog'
  s.version          = '0.1.0'
  s.summary          = 'A Log Component'
  s.description      = <<-DESC
                       YFLog is a part of YFKit
                       DESC
  s.homepage         = 'https://github.com/laichanwai/YFLog'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'laizw' => 'i@laizw.cn' }
  s.source           = { :git => 'https://github.com/laichanwai/YFLog.git', :tag => s.version }
  s.ios.deployment_target = '6.0'
  s.source_files = 'YFLog/YFLog/*.{h,m}'
end
