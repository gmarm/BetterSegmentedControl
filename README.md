# BetterSegmentedControl

[![CI Status](http://img.shields.io/travis/George Marmaridis/BetterSegmentedControl.svg?style=flat)](https://travis-ci.org/George Marmaridis/BetterSegmentedControl)
[![Version](https://img.shields.io/cocoapods/v/BetterSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/BetterSegmentedControl)
[![License](https://img.shields.io/cocoapods/l/BetterSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/BetterSegmentedControl)
[![Platform](https://img.shields.io/cocoapods/p/BetterSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/BetterSegmentedControl)

BetterSegmentedControl is an easy to use, customizable replacement for UISegmentedControl and UISwitch written in Swift.

## Features

- [x] Can be used as a segmented control or switch
- [x] Plethora of customizable options from colors to insets and radii
- [x] Designable straight in Interface Builder
- [x] Customizable behavior
- [x] Error handling

## Requirements

- iOS 8.0+
- Xcode 7.3+

## Installation

### CocoaPods

BetterSegmentedControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BetterSegmentedControl', '~> 0.1'
```

### Manually

If you prefer not to use CocoaPods, you can integrate BetterSegmentedControl into your project manually.

## Usage

```swift
let control = BetterSegmentedControl(titles: ["One", "Two", "Three"])
        control.frame = CGRect(x: 35.0, y: 40.0, width: 200.0, height: 30.0)
        control.titleFont = UIFont(name: "HelveticaNeue", size: 14.0)
        control.backgroundColor = .darkGrayColor()
        control.titleColor = .lightGrayColor()
        control.selectedTitleColor = .whiteColor()
        control.indicatorViewBackgroundColor = UIColor(red:0.55, green:0.26, blue:0.86, alpha:1.00)
        control.addTarget(self, action: #selector(ViewController.controlValueChanged(_:)), forControlEvents: .ValueChanged)
        view.addSubview(control)
```
You can find different ways of using it (such as by designing it in a Storyboard file) in the example project. To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

George Marmaridis

- https://github.com/gmarm
- https://twitter.com/gmarmas
- https://www.linkedin.com/in/gmarm
- gmarmas@gmail.com

## License

BetterSegmentedControl is available under the MIT license. See the LICENSE file for more info.
