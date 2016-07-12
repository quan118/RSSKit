Pod::Spec.new do |s|
  s.name = "RSSKit"
  s.version = "1.0.6"
  s.license = {:type => "MIT", :file => "LICENSE"}
  s.summary = "A RSS/Atom Parser in Swift"
  s.homepage = "https://github.com/quan118/RSSKit"
  s.authors = "Quan Nguyen"
  s.source = { :git => "https://github.com/quan118/RSSKit.git", :tag => "#{s.version}"}

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = "Sources/*.swift"
end
