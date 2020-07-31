Pod::Spec.new do |s|
s.name             = "BetterSegmentedControl"
s.version          = "1.3.0"
s.swift_version    = "5.1"
s.summary          = "An easy to use, customizable replacement for UISegmentedControl & UISwitch."
s.description      = <<-DESC
BetterSegmentedControl is an easy to use, customizable replacement for UISegmentedControl and UISwitch written in Swift.
DESC
s.homepage         = "https://github.com/gmarm/BetterSegmentedControl"
s.license          = 'MIT'
s.author           = { "George Marmaridis" => "gmarmas@gmail.com" }
s.source           = { :git => "https://github.com/gmarm/BetterSegmentedControl.git", :tag => "1.3.0" }
s.social_media_url = 'https://twitter.com/gmarmas'
s.platform         = :ios, '9.0'
s.requires_arc     = true
s.source_files     = 'Pod/Classes/**/*'
s.resource         = 'Pod/Assets/Localizations/*.lproj'
s.frameworks       = 'UIKit'
end
