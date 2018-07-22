# BetterSegmentedControl

![](https://img.shields.io/badge/Swift-4.1-blue.svg?style=flat)
[![Version](https://img.shields.io/cocoapods/v/BetterSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/BetterSegmentedControl)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/BetterSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/BetterSegmentedControl)
[![Platform](https://img.shields.io/cocoapods/p/BetterSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/BetterSegmentedControl)

BetterSegmentedControl is an easy to use, customizable replacement for UISegmentedControl and UISwitch written in Swift.

![Demo](https://github.com/gmarm/BetterSegmentedControl/blob/master/demo.gif)

## Features

- [x] Can be used as a segmented control or switch
- [x] Plethora of customizable options from colors to insets and radii
- [x] Designable straight in Interface Builder
- [x] Customizable behavior

## Requirements

- iOS 8.0+
- Xcode 7.3+

## Installation

### CocoaPods

BetterSegmentedControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

_Swift 4.x_
```ruby
pod 'BetterSegmentedControl', '~> 1.0'
```

_Swift 3.x_
```ruby
pod 'BetterSegmentedControl', '0.8'
```

### Carthage

If you prefer using [Carthage](https://github.com/Carthage/Carthage), simply add BetterSegmentedControl to your `Cartfile`:

_Swift 4.x_
```ruby
github "gmarm/BetterSegmentedControl" ~> 1.0
```

_Swift 3.x_
```ruby
github "gmarm/BetterSegmentedControl" 0.8
```

### Manually

If you prefer not to use CocoaPods or Carthage, you can integrate BetterSegmentedControl into your project manually.

## Usage

```swift
let control = BetterSegmentedControl(
    frame: CGRect(x: 0, y: 500, width: 300, height: 44),
    segments: LabelSegment.segments(withTitles: ["One", "Two", "Three"],
    normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
    normalTextColor: .lightGray,
    selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
    selectedTextColor: .white),
    index: 1,
    options: [.backgroundColor(.darkGray),
              .indicatorViewBackgroundColor(.blue)])
control.addTarget(self, action: #selector(ViewController.controlValueChanged(_:)), for: .valueChanged)
view.addSubview(control)
```
You can find different ways of using it (such as by designing it in a Storyboard file) in the example project. To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Contribution

Feel free to Fork, submit Pull Requests or send me your feedback and suggestions! Please make sure that tests are passing before submitting a new Pull Request.

## Author

George Marmaridis

- https://github.com/gmarm
- https://twitter.com/gmarmas
- https://www.linkedin.com/in/gmarm
- gmarmas@gmail.com

## License

BetterSegmentedControl is available under the MIT license. See the LICENSE file for more info.

I'd greatly appreciate it if you [drop me a line](https://twitter.com/gmarmas) if you decide using it in one of your apps.
