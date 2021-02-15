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
    public var selectedBackgroundColor: UIColor
    
    private let numberOfLines: Int
    private let accessibilityIdentifier: String?
    
    // MARK: Lifecycle
    public init(icon: UIImage,
                iconSize: CGSize,
                normalBackgroundColor: UIColor? = nil,
                normalIconTintColor: UIColor,
                selectedBackgroundColor: UIColor? = nil,
                selectedIconTintColor: UIColor) {
        self.icon = icon.withRenderingMode(.alwaysTemplate)
        self.iconSize = iconSize
        self.normalBackgroundColor = normalBackgroundColor ?? DefaultValues.normalBackgroundColor
        self.normalIconTintColor = normalIconTintColor
        self.selectedBackgroundColor = selectedBackgroundColor ?? DefaultValues.selectedBackgroundColor
        self.selectedIconTintColor = selectedIconTintColor
    }
    
    // MARK: BetterSegmentedControlSegment
    public var intrinsicContentSize: CGSize? { nil }
    
    public lazy var normalView: UIView = {
        return createView(withIcon: icon,
                          iconSize: iconSize,
                          backgroundColor: normalBackgroundColor,
                          iconTintColor: normalIconTintColor)
    }()
    public lazy var selectedView: UIView = {
       return createView(withIcon: icon,
                         iconSize: iconSize,
                         backgroundColor: selectedBackgroundColor,
                         iconTintColor: selectedIconTintColor)
    }()
    #warning("here")
    private func createView(withIcon icon: UIImage,
                            iconSize: CGSize,
                            backgroundColor: UIColor,
                            iconTintColor: UIColor,
                            withText text: text,
                            font: selectedFont,
                            textColor: selectedTextColor,
                            accessibilityIdentifier: accessibilityIdentifier) -> UIView {
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
                         lineBreakMode: .byTruncatingTail,
                         textAlignment: .center,
                         accessibilityIdentifier: accessibilityIdentifier)
        return view
    }
    #warning("and here")
}

public extension IconWithLabelSegment {
    class func segments(withIcons icons: [UIImage],
                        iconSize: CGSize,
                        normalBackgroundColor: UIColor? = nil,
                        normalIconTintColor: UIColor,
                        selectedBackgroundColor: UIColor? = nil,
                        selectedIconTintColor: UIColor) -> [BetterSegmentedControlSegment] {
        return icons.map {
            IconWithLabelSegment(icon: $0,
                        iconSize: iconSize,
                        normalBackgroundColor: normalBackgroundColor,
                        normalIconTintColor: normalIconTintColor,
                        selectedBackgroundColor: selectedBackgroundColor,
                        selectedIconTintColor: selectedIconTintColor)
        }
    }
}

#endif
