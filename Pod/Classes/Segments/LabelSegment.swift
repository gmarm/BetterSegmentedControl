//
//  LabelSegment.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 08/10/2017.
//

import UIKit

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
    public let text: String?
    
    public let normalFont: UIFont
    public let normalTextColor: UIColor
    public let normalBackgroundColor: UIColor
    
    public let selectedFont: UIFont
    public let selectedTextColor: UIColor
    public let selectedBackgroundColor: UIColor
    
    private let numberOfLines: Int
    private let accessibilityIdentifier: String?
    
    // MARK: Lifecycle
    public init(text: String? = nil,
                numberOfLines: Int = 1,
                normalBackgroundColor: UIColor? = nil,
                normalFont: UIFont? = nil,
                normalTextColor: UIColor? = nil,
                selectedBackgroundColor: UIColor? = nil,
                selectedFont: UIFont? = nil,
                selectedTextColor: UIColor? = nil,
                accessibilityIdentifier: String? = nil) {
        self.text = text
        self.numberOfLines = numberOfLines
        self.normalBackgroundColor = normalBackgroundColor ?? DefaultValues.normalBackgroundColor
        self.normalFont = normalFont ?? DefaultValues.font
        self.normalTextColor = normalTextColor ?? DefaultValues.normalTextColor
        self.selectedBackgroundColor = selectedBackgroundColor ?? DefaultValues.selectedBackgroundColor
        self.selectedFont = selectedFont ?? DefaultValues.font
        self.selectedTextColor = selectedTextColor ?? DefaultValues.selectedTextColor
        self.accessibilityIdentifier = accessibilityIdentifier
    }
        
        // MARK: BetterSegmentedControlSegment
        public lazy var normalView: UIView = {
            return createLabel(withText: text,
                               backgroundColor: normalBackgroundColor,
                               font: normalFont,
                               textColor: normalTextColor,
                               accessibilityIdentifier: nil)
        }()
        public lazy var selectedView: UIView = {
            return createLabel(withText: text,
                               backgroundColor: selectedBackgroundColor,
                               font: selectedFont,
                               textColor: selectedTextColor,
                               accessibilityIdentifier: accessibilityIdentifier)
        }()
        open func createLabel(withText text: String?,
                              backgroundColor: UIColor,
                              font: UIFont,
                              textColor: UIColor,
                              accessibilityIdentifier: String?) -> UILabel {
            let label = UILabel()
            label.text = text
            label.numberOfLines = numberOfLines
            label.backgroundColor = backgroundColor
            label.font = font
            label.textColor = textColor
            label.lineBreakMode = .byTruncatingTail
            label.textAlignment = .center
            label.accessibilityIdentifier = accessibilityIdentifier
            return label
        }
    }

public extension LabelSegment {
    class func segments(withTitles titles: [String],
                        numberOfLines: Int = 1,
                        normalBackgroundColor: UIColor? = nil,
                        normalFont: UIFont? = nil,
                        normalTextColor: UIColor? = nil,
                        selectedBackgroundColor: UIColor? = nil,
                        selectedFont: UIFont? = nil,
                        selectedTextColor: UIColor? = nil) -> [BetterSegmentedControlSegment] {
        return titles.map {
            LabelSegment(text: $0,
                         numberOfLines: numberOfLines,
                         normalBackgroundColor: normalBackgroundColor,
                         normalFont: normalFont,
                         normalTextColor: normalTextColor,
                         selectedBackgroundColor: selectedBackgroundColor,
                         selectedFont: selectedFont,
                         selectedTextColor: selectedTextColor)
        }
    }
    
    class func segments(withTitlesAndAccessibilityIdentifiers titlesAndAccessibilityIdentifiers: [(title: String,
                                                                                                   accessibilityIdentifier: String?)],
                        numberOfLines: Int = 1,
                        normalBackgroundColor: UIColor? = nil,
                        normalFont: UIFont? = nil,
                        normalTextColor: UIColor? = nil,
                        selectedBackgroundColor: UIColor? = nil,
                        selectedFont: UIFont? = nil,
                        selectedTextColor: UIColor? = nil) -> [BetterSegmentedControlSegment] {
        return titlesAndAccessibilityIdentifiers.map {
            LabelSegment(text: $0.title,
                         numberOfLines: numberOfLines,
                         normalBackgroundColor: normalBackgroundColor,
                         normalFont: normalFont,
                         normalTextColor: normalTextColor,
                         selectedBackgroundColor: selectedBackgroundColor,
                         selectedFont: selectedFont,
                         selectedTextColor: selectedTextColor,
                         accessibilityIdentifier: $0.accessibilityIdentifier)
        }
    }
}
