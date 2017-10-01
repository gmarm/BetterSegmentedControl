# BetterSegmentedControl

![](https://img.shields.io/badge/Swift-4.0-blue.svg?style=flat)
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
- [x] Error handling

## Requirements

- iOS 8.0+
- Xcode 7.3+

## Installation

### CocoaPods

BetterSegmentedControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

_Swift 4.0_
```ruby
pod 'BetterSegmentedControl', '~> 0.9'
```

_Swift 3.0_
```ruby
pod 'BetterSegmentedControl', '0.8'
```

_Swift 2.x_
```ruby
pod 'BetterSegmentedControl', '0.4'
```

### Carthage

If you prefer using [Carthage](https://github.com/Carthage/Carthage), simply add BetterSegmentedControl to your `Cartfile`:

_Swift 4.0_
```ruby
github "gmarm/BetterSegmentedControl" ~> 0.9
```

_Swift 3.0_
```ruby
github "gmarm/BetterSegmentedControl" 0.8
```

_Swift 2.x_
```ruby
github "gmarm/BetterSegmentedControl" 0.4
```

### Manually

If you prefer not to use CocoaPods or Carthage, you can integrate BetterSegmentedControl into your project manually.

## Usage

```swift
let control = BetterSegmentedControl(
    frame: CGRect(x: 0.0, y: 100.0, width: view.bounds.width, height: 44.0),
    titles: ["One", "Two", "Three"],
    index: 1,
    options: [.backgroundColor(UIColor(red:0.11, green:0.12, blue:0.13, alpha:1.00)),
              .titleColor(.white),
              .indicatorViewBackgroundColor(UIColor(red:0.55, green:0.26, blue:0.86, alpha:1.00)),
              .selectedTitleColor(.black),
              .titleFont(UIFont(name: "HelveticaNeue", size: 14.0)!),
              .selectedTitleFont(UIFont(name: "HelveticaNeue-Medium", size: 14.0)!)]
)
control.addTarget(self, action: #selector(ViewController.controlValueChanged(_:)), for: .valueChanged)
view.addSubview(control)
```
You can find different ways of using it (such as by designing it in a Storyboard file) in the example project. To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Todos

- [ ] Get rid of error unnecessary handling.
- [ ] Add snapshot tests.
- [ ] Allow the control to have no selected index.
- [ ] Allow UIViews that implement a protocol to be used as options.
- [ ] ~~Try to take over the world!~~ Uh, what?

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
