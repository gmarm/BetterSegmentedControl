//
//  UIColor+Helpers.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 16.10.20.
//

#if canImport(UIKit)

import UIKit

extension UIColor {
    class var appleSegmentedControlDefaultControlBackground: UIColor {
        .init(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0)
    }
    class var appleSegmentedControlDefaultIndicatorBackground: UIColor {
        .white
    }
    class var appleSegmentedControlDefaultSegmentText: UIColor {
        .black
    }
}

#endif
