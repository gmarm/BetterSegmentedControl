//
//  LabelSegment.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 08/10/2017.
//

import Foundation

open class LabelSegment: BetterSegmentedControlSegment {
    // MARK: Constants
    private struct DefaultValues {
        static let normalBackgroundColor: UIColor = .clear
        static let normalTextColor: UIColor = .white
        static let selectedBackgroundColor: UIColor = .clear
        static let selectedTextColor: UIColor = .black
        static let font: UIFont = UILabel().font
    }
    
    // MARK: Properties
    public var text: String?
    
    public var normalFont: UIFont
    public var normalTextColor: UIColor
    public var normalBackgroundColor: UIColor
    
    public var selectedFont: UIFont
    public var selectedTextColor: UIColor
    public var selectedBackgroundColor: UIColor
    
    // MARK: Lifecycle
    public init(text: String? = nil,
                normalBackgroundColor: UIColor? = nil,
                normalFont: UIFont? = nil,
                normalTextColor: UIColor? = nil,
                selectedBackgroundColor: UIColor? = nil,
                selectedFont: UIFont? = nil,
                selectedTextColor: UIColor? = nil) {
        self.text = text
        self.normalBackgroundColor = normalBackgroundColor ?? DefaultValues.normalBackgroundColor
        self.normalFont = normalFont ?? DefaultValues.font
        self.normalTextColor = normalTextColor ?? DefaultValues.normalTextColor
        self.selectedBackgroundColor = selectedBackgroundColor ?? DefaultValues.selectedBackgroundColor
        self.selectedFont = selectedFont ?? DefaultValues.font
        self.selectedTextColor = selectedTextColor ?? DefaultValues.selectedTextColor
    }
    
    // MARK: BetterSegmentedControlSegment
    public lazy var normalView: UIView = {
        return label(withText: text,
                     backgroundColor: normalBackgroundColor,
                     font: normalFont,
                     textColor: normalTextColor)
    }()
    public lazy var selectedView: UIView = {
        return label(withText: text,
                     backgroundColor: selectedBackgroundColor,
                     font: selectedFont,
                     textColor: selectedTextColor)
    }()
    private func label(withText text: String?,
                       backgroundColor: UIColor,
                       font: UIFont,
                       textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.backgroundColor = backgroundColor
        label.font = font
        label.textColor = textColor
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }
}

public extension LabelSegment {
    class func segments(withTitles titles: [String],
                        normalBackgroundColor: UIColor? = nil,
                        normalFont: UIFont? = nil,
                        normalTextColor: UIColor? = nil,
                        selectedBackgroundColor: UIColor? = nil,
                        selectedFont: UIFont? = nil,
                        selectedTextColor: UIColor? = nil) -> [BetterSegmentedControlSegment] {
        return titles.map {
            LabelSegment(text: $0,
                         normalBackgroundColor: normalBackgroundColor,
                         normalFont: normalFont,
                         normalTextColor: normalTextColor,
                         selectedBackgroundColor: selectedBackgroundColor,
                         selectedFont: selectedFont,
                         selectedTextColor: selectedTextColor)
        }
    }
}
