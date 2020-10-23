//
//  LabelSegment.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 08/10/2017.
//

#if canImport(UIKit)

import UIKit

open class LabelSegment: BetterSegmentedControlSegment {
    // MARK: Lifecycle
    public init(normalLabel: UILabel, selectedLabel: UILabel) {
        self.normalView = normalLabel
        self.selectedView = selectedLabel
    }
    
    // MARK: BetterSegmentedControlSegment
    public var intrinsicContentSize: CGSize? {
        selectedView.intrinsicContentSize
    }
    public let normalView: UIView
    public let selectedView: UIView
}

public extension LabelSegment {
    class func segments(withTitles titles: [String],
                        numberOfLines: Int = 1,
                        accessibilityIndentifier: String? = nil,
                        normalBackgroundColor: UIColor = .clear,
                        normalFont: UIFont = .systemFont(ofSize: 13),
                        normalTextColor: UIColor = .black,
                        selectedBackgroundColor: UIColor = .clear,
                        selectedFont: UIFont = .systemFont(ofSize: 13, weight: .medium),
                        selectedTextColor: UIColor = .black) -> [LabelSegment] {
        titles.map { (title) -> LabelSegment in
            let normalLabel = UILabel()
            normalLabel.textAlignment = .center
            normalLabel.text = title
            normalLabel.numberOfLines = numberOfLines
            normalLabel.backgroundColor = normalBackgroundColor
            normalLabel.font = normalFont
            normalLabel.textColor = normalTextColor
            
            let selectedLabel = UILabel()
            selectedLabel.textAlignment = .center
            selectedLabel.text = title
            selectedLabel.numberOfLines = numberOfLines
            selectedLabel.backgroundColor = selectedBackgroundColor
            selectedLabel.font = selectedFont
            selectedLabel.textColor = selectedTextColor
            selectedLabel.accessibilityIdentifier = accessibilityIndentifier
            
            return LabelSegment(normalLabel: normalLabel, selectedLabel: selectedLabel)
        }
    }
}

extension LabelSegment {
    class func defaultSegments() -> [LabelSegment] {
        segments(withTitles: ["First", "Second", "Third"])
    }
}

#endif
