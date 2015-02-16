Pod::Spec.new do |s|
  s.name         	 = "THMoreFromDeveloper"
  s.version      	 = "0.1.1"
  s.summary      	 = "Control to show other APPs from a Developer"
  s.homepage     	 = "https://github.com/hons82/THMoreFromDeveloper"
  s.license      	 = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author       	 = { "Hannes Tribus" => "hons82@gmail.com" }
  s.source       	 = { :git => "https://github.com/hons82/THMoreFromDeveloper.git", :tag => "v#{s.version}" }
  s.platform     	 = :ios, '6.1'
  s.requires_arc 	 = true
  s.source_files 	 = 'THMoreFromDeveloper/*.{h,m}'
  s.resource_bundles = {'THMoreFromDeveloperImages' => ['THMoreFromDeveloper/Images.xcassets']}
  s.frameworks   	 =  'SystemConfiguration'
  
  #dependencies
  s.dependency 		'Reachability', '~> 3.2'
  s.dependency  	'SDWebImage', '~> 3.7.1'
  s.dependency		'THCache', '~> 0.9.0'
end
