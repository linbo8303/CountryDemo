# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'CountryDemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CountryDemo
  pod 'Mantle'
  pod 'Kingfisher'
  pod 'SnapKit'
  pod 'SVProgressHUD'
  
  target 'CountryDemoTests' do
      pod 'Mantle'
  end
  
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
        end
    end
end
