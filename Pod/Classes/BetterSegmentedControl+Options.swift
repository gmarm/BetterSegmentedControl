//
//  Options.swift
//  Pods
//
//  Created by George Marmaridis on 15/05/2017.
//
//

#if canImport(UIKit)

import UIKit

public extension BetterSegmentedControl {
    enum Option {
        /* Selected segment */
        case indicatorViewBackgroundColor(UIColor)
        case indicatorViewInset(CGFloat)
        case indicatorViewBorderWidth(CGFloat)
        case indicatorViewBorderColor(UIColor)
        
        /* Behavior */
        case alwaysAnnouncesValue(Bool)
        case announcesValueImmediately(Bool)
        case panningDisabled(Bool)
        
        /* Animation */
        case animationDuration(TimeInterval)
        case animationSpringDamping(CGFloat)
        
        /* Other */
        case backgroundColor(UIColor)
        case cornerRadius(CGFloat)
    }
}

#endif
