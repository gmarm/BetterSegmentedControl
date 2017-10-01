//
//  Options.swift
//  Pods
//
//  Created by George Marmaridis on 15/05/2017.
//
//

import Foundation

public enum BetterSegmentedControlOption {
    /* Non-selected segments */
    case titleColor(UIColor)
    case titleFont(UIFont)
    
    /* Selected segment */
    case selectedTitleColor(UIColor)
    case selectedTitleFont(UIFont)
    
    /* Other segment options */
    case titleBorderWidth(CGFloat)
    case titleBorderColor(UIColor)
    case titleNumberOfLines(Int)
    
    /* Selected segment */
    case indicatorViewBackgroundColor(UIColor)
    case indicatorViewInset(CGFloat)
    case indicatorViewBorderWidth(CGFloat)
    case indicatorViewBorderColor(UIColor)
    
    /* Behavior */
    case alwaysAnnouncesValue(Bool)
    case announcesValueImmediately(Bool)
    case panningDisabled(Bool)
    
    /* Other */
    case backgroundColor(UIColor)
    case cornerRadius(CGFloat)
    case bouncesOnChange(Bool)
}
