Pod::Spec.new do |s|
  s.name         = "ARKit"
  s.version      = "0.0.1"
  s.summary      = "Layout and Theme helpers for ios."
  s.homepage     = "https://github.com/alpinereplay/arKit"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Brian Bal" => "briantbal@gmail.com" }
  s.source       = { :git => "https://github.com/alpinereplay/arKit.git", :commit => "27fcac52d9e4e8b86dcd67334ff884810046c52d" }
  s.ios.deployment_target = '6.0'
  s.source_files = 'ARKit'
  s.requires_arc = true
end
