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
        static let normalFont: UIFont = UILabel().font
        static let normalTextColor: UIColor = .white
        static let selectedBackgroundColor: UIColor = .clear
        static let selectedFont: UIFont = UILabel().font
        static let selectedTextColor: UIColor = .black
    }
    
    // MARK: Properties
    public var text: String?
    public var normalBackgroundColor: UIColor
    public var normalFont: UIFont
    public var normalTextColor: UIColor
    public var selectedBackgroundColor: UIColor
    public var selectedFont: UIFont
    public var selectedTextColor: UIColor
    
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
        self.normalFont = normalFont ?? DefaultValues.normalFont
        self.normalTextColor = normalTextColor ?? DefaultValues.normalTextColor
        self.selectedBackgroundColor = selectedBackgroundColor ?? DefaultValues.selectedBackgroundColor
        self.selectedFont = selectedFont ?? DefaultValues.selectedFont
        self.selectedTextColor = selectedTextColor ?? DefaultValues.selectedTextColor
    }
    
    // MARK:- BetterSegmentedControlSegment
    public lazy var normalView: UIView = {
        let label = UILabel()
        label.text = text
        label.backgroundColor = normalBackgroundColor
        label.font = normalFont
        label.textColor = normalTextColor
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    public lazy var selectedView: UIView = {
        let label = UILabel()
        label.text = text
        label.backgroundColor = selectedBackgroundColor
        label.font = normalFont
        label.textColor = selectedTextColor
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
}
