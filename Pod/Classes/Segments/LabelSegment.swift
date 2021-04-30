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
        static var normalAttributes: ((UIFont?, UIColor?) -> [NSAttributedString.Key: Any]) = { (normalFont, normalTextColor) in
            var attrs = [NSAttributedString.Key: Any]()
            attrs[NSAttributedString.Key.font] = normalFont == nil ? DefaultValues.normalFont : normalFont!
            attrs[NSAttributedString.Key.foregroundColor] =  normalTextColor == nil ? DefaultValues.normalTextColor : normalTextColor!
            return attrs
        }
        
        static let selectedBackgroundColor: UIColor = .clear
        static let selectedTextColor: UIColor = .black
        static let selectedFont: UIFont = .systemFont(ofSize: 13, weight: .medium)
        static var selectedAttributes: ((UIFont?, UIColor?) -> [NSAttributedString.Key: Any]) = { (selectedFont, selectedTextColor) in
            var attrs = [NSAttributedString.Key: Any]()
            attrs[NSAttributedString.Key.font] = selectedFont == nil ? DefaultValues.selectedFont : selectedFont!
            attrs[NSAttributedString.Key.foregroundColor] = selectedTextColor == nil ? DefaultValues.selectedTextColor : selectedTextColor!
            return attrs
        }
    }
    
    // MARK: Properties
    public let text: String?
    
    public let normalFont: UIFont
    public let normalTextColor: UIColor
    public let normalBackgroundColor: UIColor
    public let normalAttributes: [NSAttributedString.Key: Any]
    
    public let selectedFont: UIFont
    public let selectedTextColor: UIColor
    public let selectedBackgroundColor: UIColor
    public let selectedAttributes: [NSAttributedString.Key: Any]
    
    private let numberOfLines: Int
    private let accessibilityIdentifier: String?
    
    // MARK: Lifecycle
    public init(text: String? = nil,
                numberOfLines: Int = 1,
                normalBackgroundColor: UIColor? = nil,
                normalFont: UIFont? = nil,
                normalTextColor: UIColor? = nil,
                normalAttributes: [NSAttributedString.Key: Any]? = nil,
                selectedBackgroundColor: UIColor? = nil,
                selectedFont: UIFont? = nil,
                selectedTextColor: UIColor? = nil,
                selectedAttributes: [NSAttributedString.Key: Any]? = nil,
                accessibilityIdentifier: String? = nil) {
        self.text = text
        self.numberOfLines = numberOfLines
        self.normalBackgroundColor = normalBackgroundColor ?? DefaultValues.normalBackgroundColor
        self.normalFont = normalFont ?? DefaultValues.normalFont
        self.normalTextColor = normalTextColor ?? DefaultValues.normalTextColor
        self.normalAttributes = normalAttributes ?? DefaultValues.normalAttributes(normalFont, normalTextColor)
        self.selectedBackgroundColor = selectedBackgroundColor ?? DefaultValues.selectedBackgroundColor
        self.selectedFont = selectedFont ?? DefaultValues.selectedFont
        self.selectedTextColor = selectedTextColor ?? DefaultValues.selectedTextColor
        self.selectedAttributes = selectedAttributes ?? DefaultValues.selectedAttributes(selectedFont, selectedTextColor)
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
                    attributes: normalAttributes,
                    accessibilityIdentifier: accessibilityIdentifier)
    }()
    public lazy var selectedView: UIView = {
        createLabel(withText: text,
                    backgroundColor: selectedBackgroundColor,
                    font: selectedFont,
                    textColor: selectedTextColor,
                    attributes: selectedAttributes,
                    accessibilityIdentifier: accessibilityIdentifier)
    }()
    open func createLabel(withText text: String?,
                          backgroundColor: UIColor,
                          font: UIFont,
                          textColor: UIColor,
                          attributes: [NSAttributedString.Key: Any],
                          accessibilityIdentifier: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = numberOfLines
        label.backgroundColor = backgroundColor
        label.font = font
        label.textColor = textColor
        label.attributedText = text == nil ? nil : NSAttributedString(string: text!, attributes: attributes)
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
                        normalAttributes: [NSAttributedString.Key: Any]? = nil,
                        selectedBackgroundColor: UIColor? = nil,
                        selectedFont: UIFont? = nil,
                        selectedTextColor: UIColor? = nil,
                        selectedAttributes: [NSAttributedString.Key: Any]? = nil) -> [BetterSegmentedControlSegment] {
        titles.map {
            LabelSegment(text: $0,
                         numberOfLines: numberOfLines,
                         normalBackgroundColor: normalBackgroundColor,
                         normalFont: normalFont,
                         normalTextColor: normalTextColor,
                         normalAttributes: normalAttributes,
                         selectedBackgroundColor: selectedBackgroundColor,
                         selectedFont: selectedFont,
                         selectedTextColor: selectedTextColor,
                         selectedAttributes: selectedAttributes)
        }
    }
}

#endif
