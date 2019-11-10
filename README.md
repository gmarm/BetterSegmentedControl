# BetterSegmentedControl

![](https://img.shields.io/badge/Swift-5.1-blue.svg?style=flat)
[![Version](https://img.shields.io/cocoapods/v/BetterSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/BetterSegmentedControl)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/BetterSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/BetterSegmentedControl)
[![Platform](https://img.shields.io/cocoapods/p/BetterSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/BetterSegmentedControl)

BetterSegmentedControl is an easy to use, customizable replacement for UISegmentedControl and UISwitch written in Swift.

![Demo](https://github.com/gmarm/BetterSegmentedControl/blob/master/demo.gif)

## Features

- [x] Can be used as a segmented control or switch
- [x] Plethora of customizable options from colors to insets, radii, animations
- [x] Use text or icons as segments, or add your own custom segments
- [x] Designable straight in Interface Builder
- [x] Customizable behavior
- [x] Right-to-left languages support

## Requirements

- iOS 9.0+
- Xcode 8+

## Installation

### Swift Package Manager

BetterSegmentedControl is available through Swift Package Manager. To install
it, simply go to Xcode under `File > Swift Packages > Add Package Dependency...`

### CocoaPods

BetterSegmentedControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
# Swift 5.1
pod 'BetterSegmentedControl', '~> 1.3'

# Swift 4
pod 'BetterSegmentedControl', '1.0'

# Swift 3 / Objective-C
pod 'BetterSegmentedControl', '0.8'
```

### Carthage

If you prefer using [Carthage](https://github.com/Carthage/Carthage), simply add BetterSegmentedControl to your `Cartfile`:

```ruby
# Swift 5.1
github "gmarm/BetterSegmentedControl" ~> 1.3

# Swift 4
github "gmarm/BetterSegmentedControl" 1.0

# Swift 3 / Objective-C
github "gmarm/BetterSegmentedControl" 0.8
```

### Manually

If you prefer not to use CocoaPods or Carthage, you can integrate BetterSegmentedControl into your project manually.

## Usage

```swift
let control = BetterSegmentedControl(
    frame: CGRect(x: 0, y: 0, width: 300, height: 44),
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
