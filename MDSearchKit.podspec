
Pod::Spec.new do |s|
  s.name             = 'MDSearchKit'
  s.version          = '0.0.2'
  s.summary          = '搜索框组件'
  s.homepage         = 'https://github.com/unicorn-china/MDSearchKit_iOS.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '李永杰' => 'yj.li@muheda.com' }
  s.source           = { :git => 'https://github.com/unicorn-china/MDSearchKit_iOS.git', :tag => s.version.to_s }
  s.requires_arc     = true

  s.ios.deployment_target = '8.0'

  s.source_files = 'MDSearchKit/*.{h,m}'
  s.resources = 'MDSearchKit/resources/*.png'

end
