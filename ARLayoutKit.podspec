Pod::Spec.new do |s|
  s.name         = "ARLayoutKit"
  s.version      = "0.0.1"
  s.summary      = "Layout and Theme helpers for ios."
  s.homepage     = "https://github.com/alpinereplay/arKit"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Brian Bal" => "briantbal@gmail.com" }
  s.source       = { :git => "https://github.com/alpinereplay/arKit.git", :commit => "12c5d6ace409acf1bbc9de9d8faac71567a8346c" }
  s.ios.deployment_target = '6.0'
  s.source_files = "ARKit/*.{h,m}", "ARKit/**/*.{h,m}"
  s.requires_arc = true
end

