require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-giphy-keyboard"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                    react-native-giphy-keyboard
                   DESC
  s.homepage     = "https://github.com/github_account/react-native-giphy"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "Your Name" => "yourname@email.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/github_account/react-native-giphy.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true
  s.static_framework = true
  s.swift_version = "4.1"

  s.dependency "React"
  s.dependency "Giphy", "~> 1.1.9"
end

