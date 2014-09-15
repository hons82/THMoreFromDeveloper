Pod::Spec.new do |s|
  s.name         	= "THMoreFromDeveloper"
  s.version      	= "0.0.2"
  s.summary      	= "Control to show other APPs from a Developer"
  s.homepage     	= "https://github.com/hons82/THMoreFromDeveloper"
  s.license      	= { :type => 'MIT', :file => 'LICENSE.md' }
  s.author       	= { "Hannes Tribus" => "hons82@gmail.com" }
  s.source       	= { :git => "https://github.com/hons82/THMoreFromDeveloper.git", :tag => "v#{s.version}" }
  s.platform     	= :ios, '6.1'
  s.requires_arc 	= true
  s.source_files 	= 'THMoreFromDeveloper/*.{h,m}'
  s.resources 	 	= ["THMoreFromDeveloper/Images/*.png"]
  s.frameworks   	=  'SystemConfiguration'
  
  #dependencies
  s.dependency 		'Reachability', '~> 3.1.1'
  s.dependency  	'SDWebImage', '~> 3.7.1'
end