//
//  LabelSegment.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 08/10/2017.
//

#if canImport(UIKit)

import UIKit

open class LabelSegment: BetterSegmentedControlSegment {
    // MARK: Constants
    private struct DefaultValues {
        static let normalBackgroundColor: UIColor = .clear
        static let normalTextColor: UIColor = .black
        static let normalFont: UIFont = .systemFont(ofSize: 13)
        static let selectedBackgroundColor: UIColor = .clear
        static let selectedTextColor: UIColor = .black
        static let selectedFont: UIFont = .systemFont(ofSize: 13, weight: .medium)
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
        self.normalFont = normalFont ?? DefaultValues.normalFont
        self.normalTextColor = normalTextColor ?? DefaultValues.normalTextColor
        self.selectedBackgroundColor = selectedBackgroundColor ?? DefaultValues.selectedBackgroundColor
        self.selectedFont = selectedFont ?? DefaultValues.selectedFont
        self.selectedTextColor = selectedTextColor ?? DefaultValues.selectedTextColor
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    // MARK: BetterSegmentedControlSegment
    public var intrinsicContentSize: CGSize? {
        selectedView.intrinsicContentSize
    }
    
    public lazy var normalView: UIView = {
        createLabel(withText: text,
                    backgroundColor: normalBackgroundColor,
                    font: normalFont,
                    textColor: normalTextColor,
                    accessibilityIdentifier: accessibilityIdentifier)
    }()
    public lazy var selectedView: UIView = {
        createLabel(withText: text,
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
        titles.map {
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
}

#endif
