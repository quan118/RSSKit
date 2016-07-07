Pod::Spec.new do |s|
  s.name = 'RSSKit'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'A RSS/Atom Parser in Swift'
  s.homepage = 'https://github.com/quan118/RSSKit'
  s.authors = 'Quan Nguyen'
  s.source = { :git => 'https://github.com/quan118/RSSKit.git'}

  s.ios.deployment_target = '8.4'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'Source/*.swift'
end