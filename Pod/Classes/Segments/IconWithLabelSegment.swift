//
//  IconWithLabelSegment.swift
//  BetterSegmentedControl
//
//  Created by Arman Zoghi on 2/14/21.
//

#if canImport(UIKit)

import UIKit

open class IconWithLabelSegment: BetterSegmentedControlSegment {
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
    public var icon: UIImage
    public var iconSize: CGSize
    public let text: String?
    
    public var normalIconTintColor: UIColor
    public let normalFont: UIFont
    public let normalTextColor: UIColor
    public var normalBackgroundColor: UIColor
    
    public var selectedIconTintColor: UIColor
    public let selectedFont: UIFont
    public let selectedTextColor: UIColor
    public var selectedBackgroundColor: UIColor
    
    private let numberOfLines: Int
    private let accessibilityIdentifier: String?
    
    // MARK: Lifecycle
    public init(icon: UIImage,
                text: String? = nil,
                iconSize: CGSize,
                numberOfLines: Int = 1,
                normalBackgroundColor: UIColor? = nil,
                normalIconTintColor: UIColor,
                normalFont: UIFont? = nil,
                normalTextColor: UIColor? = nil,
                selectedBackgroundColor: UIColor? = nil,
                selectedIconTintColor: UIColor,
                selectedFont: UIFont? = nil,
                selectedTextColor: UIColor? = nil,
                accessibilityIdentifier: String? = nil) {
        self.icon = icon.withRenderingMode(.alwaysTemplate)
        self.text = text
        self.iconSize = iconSize
        self.numberOfLines = numberOfLines
        self.normalBackgroundColor = normalBackgroundColor ?? DefaultValues.normalBackgroundColor
        self.normalIconTintColor = normalIconTintColor
        self.normalFont = normalFont ?? DefaultValues.normalFont
        self.normalTextColor = normalTextColor ?? DefaultValues.normalTextColor
        self.selectedBackgroundColor = selectedBackgroundColor ?? DefaultValues.selectedBackgroundColor
        self.selectedFont = selectedFont ?? DefaultValues.selectedFont
        self.selectedTextColor = selectedTextColor ?? DefaultValues.selectedTextColor
        self.selectedIconTintColor = selectedIconTintColor
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    // MARK: BetterSegmentedControlSegment
    public var intrinsicContentSize: CGSize? { nil }
    
    public lazy var normalView: UIView = {
        return createView(withIcon: icon,
                          iconSize: iconSize,
                          backgroundColor: normalBackgroundColor,
                          iconTintColor: normalIconTintColor,
                          withText: text,
                          font: normalFont,
                          textColor: normalTextColor,
                          accessibilityIdentifier: accessibilityIdentifier)
    }()
    public lazy var selectedView: UIView = {
       return createView(withIcon: icon,
                         iconSize: iconSize,
                         backgroundColor: selectedBackgroundColor,
                         iconTintColor: selectedIconTintColor,
                         withText: text,
                         font: selectedFont,
                         textColor: selectedTextColor,
                         accessibilityIdentifier: accessibilityIdentifier)
    }()
    private func createView(withIcon icon: UIImage,
                            iconSize: CGSize,
                            backgroundColor: UIColor,
                            iconTintColor: UIColor,
                            withText text: String?,
                            font: UIFont?,
                            textColor: UIColor?,
                            accessibilityIdentifier: String?) -> UIView {
        let view = IconWithLabelView()
        view.backgroundColor = backgroundColor
        view.imageViewConfig(icon: icon,
                             width: iconSize.width,
                             height: iconSize.height,
                             contentMode: .scaleAspectFit,
                             tintColor: iconTintColor)
        view.labelConfig(text: text,
                         numberOfLines: numberOfLines,
                         font: font,
                         textColor: textColor,
                         lineBreakMode: .byTruncatingTail,
                         textAlignment: .center,
                         accessibilityIdentifier: accessibilityIdentifier)
        return view
    }
}

public extension IconWithLabelSegment {
    class func segments(withIconsAndLabels iconsAndLabelS: [IconWithLabel],
                        iconSize: CGSize,
                        numberOfLines: Int = 1,
                        normalBackgroundColor: UIColor? = nil,
                        normalIconTintColor: UIColor,
                        normalFont: UIFont? = nil,
                        normalTextColor: UIColor? = nil,
                        selectedBackgroundColor: UIColor? = nil,
                        selectedIconTintColor: UIColor,
                        selectedFont: UIFont? = nil,
                        selectedTextColor: UIColor? = nil) -> [BetterSegmentedControlSegment] {
        return iconsAndLabelS.map {
            IconWithLabelSegment(icon: $0.icon,
                                 text: $0.title,
                        iconSize: iconSize,
                        numberOfLines: numberOfLines,
                        normalBackgroundColor: normalBackgroundColor,
                        normalIconTintColor: normalIconTintColor,
                        normalFont: normalFont,
                        normalTextColor: normalTextColor,
                        selectedBackgroundColor: selectedBackgroundColor,
                        selectedIconTintColor: selectedIconTintColor,
                        selectedFont: selectedFont,
                        selectedTextColor: selectedTextColor)
        }
    }
}

#endif
