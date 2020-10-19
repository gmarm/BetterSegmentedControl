//
//  BetterSegmentedControl+PredefinedStyles.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 18.10.20.
//

import UIKit

public extension BetterSegmentedControl {
     class func appleStyled(frame: CGRect, titles: [String]) -> BetterSegmentedControl {
        let control = BetterSegmentedControl(
            frame: frame,
            segments: LabelSegment.segments(withTitles: titles,
                                            normalFont: .systemFont(ofSize: 13.0),
                                            normalTextColor: .appleSegmentedControlDefaultSegmentText,
                                            selectedFont: .systemFont(ofSize: 13.0, weight: .medium),
                                            selectedTextColor: .appleSegmentedControlDefaultSegmentText),
            index: 0,
            options: [.backgroundColor(.appleSegmentedControlDefaultControlBackground),
                      .indicatorViewBackgroundColor(.appleSegmentedControlDefaultIndicatorBackground),
                      .cornerRadius(8),
                      .indicatorViewInset(2)])
        control.indicatorView.layer.shadowColor = UIColor.black.cgColor
        control.indicatorView.layer.shadowOpacity = 0.1
        control.indicatorView.layer.shadowOffset = CGSize(width: 1, height: 1)
        control.indicatorView.layer.shadowRadius = 2
        
        return control
    }
}
