//
//  BetterSegmentedControl+IndicatorView.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 19.10.20.
//

#if canImport(UIKit)

import UIKit

extension BetterSegmentedControl {
    open class IndicatorView: UIView {
        // MARK: Properties
        let segmentMaskView = UIView()
        var cornerRadius: CGFloat = 0.0 {
            didSet {
                layer.cornerRadius = cornerRadius
                segmentMaskView.layer.cornerRadius = cornerRadius
            }
        }
        override open var frame: CGRect {
            didSet {
                segmentMaskView.frame = frame
            }
        }
        
        // MARK: Initialization
        init() {
            super.init(frame: CGRect.zero)
            completeInit()
        }
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            completeInit()
        }
        private func completeInit() {
            segmentMaskView.backgroundColor = .black
        }
    }
}

#endif
