//
//  BetterSegmentedControl.swift
//
//  Created by George Marmaridis on 01/04/16.
//  Copyright © 2016 George Marmaridis. All rights reserved.
//

import UIKit

// MARK: - BetterSegmentedControl
@IBDesignable open class BetterSegmentedControl: UIControl {
    // MARK: - IndicatorView
    fileprivate class IndicatorView: UIView {
        // MARK: - Properties
        fileprivate let titleMaskView = UIView()
        
        fileprivate var cornerRadius: CGFloat! {
            didSet {
                layer.cornerRadius = cornerRadius
                titleMaskView.layer.cornerRadius = cornerRadius
            }
        }
        
        override open var frame: CGRect {
            didSet {
                titleMaskView.frame = frame
            }
        }
        
        // MARK: - Lifecycle
        init() {
            super.init(frame: CGRect.zero)
            finishInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            finishInit()
        }
        
        fileprivate func finishInit() {
            layer.masksToBounds = true
            titleMaskView.backgroundColor = UIColor.black
        }
    }
    
    // MARK: - Constants
    fileprivate struct AnimationParameters {
        fileprivate static let animationWithBounceDuration: TimeInterval = 0.3
        fileprivate static let animationWithBounceSpringDamping: CGFloat = 0.75
        fileprivate static let animationNoBounceDuration: TimeInterval = 0.2
    }
    fileprivate struct DefaultColors {
        fileprivate static let backgroundColor: UIColor = UIColor.white
        fileprivate static let titleColor: UIColor = UIColor.black
        fileprivate static let indicatorViewBackgroundColor: UIColor = UIColor.black
        fileprivate static let selectedTitleColor: UIColor = UIColor.white
    }
    
    // MARK: - Error handling
    public enum IndexError: Error {
        case indexBeyondBounds(UInt)
    }
    
    // MARK: - Public properties
    /// The selected index
    public fileprivate(set) var index: UInt
    /// The titles / options available for selection
    public var titles: [String] {
        get {
            let titleLabels = titleLabelsView.subviews as! [UILabel]
            return titleLabels.map { $0.text! }
        }
        set {
            guard newValue.count > 1 else {
                return
            }
            let labels: [(UILabel, UILabel)] = newValue.map {
                (string) -> (UILabel, UILabel) in
                
                let titleLabel = UILabel()
                titleLabel.textColor = titleColor
                titleLabel.text = string
                titleLabel.lineBreakMode = .byTruncatingTail
                titleLabel.textAlignment = .center
                titleLabel.font = titleFont
                
                let selectedTitleLabel = UILabel()
                selectedTitleLabel.textColor = selectedTitleColor
                selectedTitleLabel.text = string
                selectedTitleLabel.lineBreakMode = .byTruncatingTail
                selectedTitleLabel.textAlignment = .center
                selectedTitleLabel.font = selectedTitleFont
                
                return (titleLabel, selectedTitleLabel)
            }
            
            titleLabelsView.subviews.forEach({ $0.removeFromSuperview() })
            selectedTitleLabelsView.subviews.forEach({ $0.removeFromSuperview() })
            
            for (inactiveLabel, activeLabel) in labels {
                titleLabelsView.addSubview(inactiveLabel)
                selectedTitleLabelsView.addSubview(activeLabel)
            }
            
            setNeedsLayout()
        }
    }
    /// Whether the indicator should bounce when selecting a new index. Defaults to true.
    public var bouncesOnChange = true
    /// Whether the the control should always send the .ValueChanged event, regardless of the index remaining unchanged after interaction. Defaults to false.
    public var alwaysAnnouncesValue = false
    /// Whether the the control should ignore pan gestures. Defaults to false.
    public var panningDisabled = false
    /// The control's and indicator's corner radii
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            indicatorView.cornerRadius = newValue - indicatorViewInset
        }
    }
    /// The indicator view's background color
    @IBInspectable public var indicatorViewBackgroundColor: UIColor? {
        get {
            return indicatorView.backgroundColor
        }
        set { indicatorView.backgroundColor = newValue }
    }
    /// The indicator view's inset. Defaults to 2.0.
    @IBInspectable public var indicatorViewInset: CGFloat = 2.0 {
        didSet { setNeedsLayout() }
    }
    /// The text color of the non-selected titles / options
    @IBInspectable public var titleColor: UIColor  {
        didSet {
            if !titleLabels.isEmpty {
                for label in titleLabels {
                    label.textColor = titleColor
                }
            }
        }
    }
    /// The text color of the selected title / option
    @IBInspectable public var selectedTitleColor: UIColor {
        didSet {
            if !selectedTitleLabels.isEmpty {
                for label in selectedTitleLabels {
                    label.textColor = selectedTitleColor
                }
            }
        }
    }
    /// The titles' font
    public var titleFont: UIFont = UILabel().font {
        didSet {
            if !titleLabels.isEmpty {
                for label in titleLabels {
                    label.font = titleFont
                }
            }
        }
    }
    /// The selected title's font
    public var selectedTitleFont: UIFont = UILabel().font {
        didSet {
            if !selectedTitleLabels.isEmpty {
                for label in selectedTitleLabels {
                    label.font = selectedTitleFont
                }
            }
        }
    }
    
    // MARK: - Private properties
    fileprivate let titleLabelsView = UIView()
    fileprivate let selectedTitleLabelsView = UIView()
    fileprivate let indicatorView = IndicatorView()
    fileprivate var initialIndicatorViewFrame: CGRect?
    
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer!
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer!
    
    fileprivate var width: CGFloat { return bounds.width }
    fileprivate var height: CGFloat { return bounds.height }
    fileprivate var titleLabelsCount: Int { return titleLabelsView.subviews.count }
    fileprivate var titleLabels: [UILabel] { return titleLabelsView.subviews as! [UILabel] }
    fileprivate var selectedTitleLabels: [UILabel] { return selectedTitleLabelsView.subviews as! [UILabel] }
    fileprivate var totalInsetSize: CGFloat { return indicatorViewInset * 2.0 }
    fileprivate lazy var defaultTitles: [String] = { return ["First", "Second"] }()
    
    // MARK: - Lifecycle
    required public init?(coder aDecoder: NSCoder) {
        self.index = 0
        self.titleColor = DefaultColors.titleColor
        self.selectedTitleColor = DefaultColors.selectedTitleColor
        super.init(coder: aDecoder)
        titles = defaultTitles
        finishInit()
    }
    public init(frame: CGRect,
                titles: [String],
                index: UInt,
                backgroundColor: UIColor,
                titleColor: UIColor,
                indicatorViewBackgroundColor: UIColor,
                selectedTitleColor: UIColor) {
        self.index = index
        self.titleColor = titleColor
        self.selectedTitleColor = selectedTitleColor
        super.init(frame: frame)
        self.titles = titles
        self.backgroundColor = backgroundColor
        self.indicatorViewBackgroundColor = indicatorViewBackgroundColor
        finishInit()
    }
    @available(*, deprecated, message: "Use init(frame:titles:index:backgroundColor:titleColor:indicatorViewBackgroundColor:selectedTitleColor:) instead.")
    convenience public init(titles: [String]) {
        self.init(frame: CGRect.zero,
                  titles: titles,
                  index: 0,
                  backgroundColor: DefaultColors.backgroundColor,
                  titleColor: DefaultColors.titleColor,
                  indicatorViewBackgroundColor: DefaultColors.indicatorViewBackgroundColor,
                  selectedTitleColor: DefaultColors.selectedTitleColor)
    }
    
    @available(*, deprecated, message: "Use init(frame:titles:index:backgroundColor:titleColor:indicatorViewBackgroundColor:selectedTitleColor:) instead.")
    convenience override public init(frame: CGRect) {
        self.init(frame: frame,
                  titles: ["First", "Second"],
                  index: 0,
                  backgroundColor: DefaultColors.backgroundColor,
                  titleColor: DefaultColors.titleColor,
                  indicatorViewBackgroundColor: DefaultColors.indicatorViewBackgroundColor,
                  selectedTitleColor: DefaultColors.selectedTitleColor)
    }
    @available(*, unavailable, message: "Use init(frame:titles:index:backgroundColor:titleColor:indicatorViewBackgroundColor:selectedTitleColor:) instead.")
    convenience init() {
        self.init(frame: CGRect.zero,
                  titles: ["First", "Second"],
                  index: 0,
                  backgroundColor: DefaultColors.backgroundColor,
                  titleColor: DefaultColors.titleColor,
                  indicatorViewBackgroundColor: DefaultColors.indicatorViewBackgroundColor,
                  selectedTitleColor: DefaultColors.selectedTitleColor)
    }
    fileprivate func finishInit() {
        layer.masksToBounds = true
        
        addSubview(titleLabelsView)
        addSubview(indicatorView)
        addSubview(selectedTitleLabelsView)
        selectedTitleLabelsView.layer.mask = indicatorView.titleMaskView.layer
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BetterSegmentedControl.tapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(BetterSegmentedControl.pan(_:)))
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        guard titleLabelsCount > 1 else {
            return
        }
        
        titleLabelsView.frame = bounds
        selectedTitleLabelsView.frame = bounds
        
        indicatorView.frame = elementFrame(forIndex: index)
        
        for index in 0...titleLabelsCount-1 {
            let frame = elementFrame(forIndex: UInt(index))
            titleLabelsView.subviews[index].frame = frame
            selectedTitleLabelsView.subviews[index].frame = frame
        }
    }
    
    // MARK: - Index Setting
    /*!
     Sets the control's index.
     
     - parameter index:    The new index
     - parameter animated: (Optional) Whether the change should be animated or not. Defaults to true.
     
     - throws: An error of type IndexBeyondBounds(UInt) is thrown if an index beyond the available indices is passed.
     */
    public func set(index: UInt, animated: Bool = true) throws {
        guard titleLabels.indices.contains(Int(index)) else {
            throw IndexError.indexBeyondBounds(index)
        }
        let oldIndex = self.index
        self.index = index
        moveIndicatorViewToIndex(animated, shouldSendEvent: (self.index != oldIndex || alwaysAnnouncesValue))
    }
    
    // MARK: - Animations
    fileprivate func moveIndicatorViewToIndex(_ animated: Bool, shouldSendEvent: Bool) {
        if animated {
            UIView.animate(withDuration: bouncesOnChange ? AnimationParameters.animationWithBounceDuration : AnimationParameters.animationNoBounceDuration,
                           delay: 0.0,
                           usingSpringWithDamping: bouncesOnChange ? AnimationParameters.animationWithBounceSpringDamping : 1.0,
                           initialSpringVelocity: 0.0,
                           options: [UIViewAnimationOptions.beginFromCurrentState, UIViewAnimationOptions.curveEaseOut],
                           animations: {
                            () -> Void in
                            self.moveIndicatorView()
                }, completion: { (finished) -> Void in
                    if finished && shouldSendEvent {
                        self.sendActions(for: .valueChanged)
                    }
            })
        }
        else {
            moveIndicatorView()
            self.sendActions(for: .valueChanged)
        }
    }
    
    // MARK: - Helpers
    fileprivate func elementFrame(forIndex index: UInt) -> CGRect {
        let elementWidth = (width - totalInsetSize) / CGFloat(titleLabelsCount)
        return CGRect(x: CGFloat(index) * elementWidth + indicatorViewInset,
                      y: indicatorViewInset,
                      width: elementWidth,
                      height: height - totalInsetSize)
    }
    fileprivate func nearestIndex(toPoint point: CGPoint) -> UInt {
        let distances = titleLabels.map { abs(point.x - $0.center.x) }
        return UInt(distances.index(of: distances.min()!)!)
    }
    fileprivate func moveIndicatorView() {
        self.indicatorView.frame = self.titleLabels[Int(self.index)].frame
        self.layoutIfNeeded()
    }
    
    // MARK: - Action handlers
    @objc fileprivate func tapped(_ gestureRecognizer: UITapGestureRecognizer!) {
        let location = gestureRecognizer.location(in: self)
        try! set(index: nearestIndex(toPoint: location))
    }
    @objc fileprivate func pan(_ gestureRecognizer: UIPanGestureRecognizer!) {
        guard !panningDisabled else {
            return
        }
        
        switch gestureRecognizer.state {
        case .began:
            initialIndicatorViewFrame = indicatorView.frame
        case .changed:
            var frame = initialIndicatorViewFrame!
            frame.origin.x += gestureRecognizer.translation(in: self).x
            frame.origin.x = max(min(frame.origin.x, bounds.width - indicatorViewInset - frame.width), indicatorViewInset)
            indicatorView.frame = frame
        case .ended, .failed, .cancelled:
            try! set(index: nearestIndex(toPoint: indicatorView.center))
        default: break
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension BetterSegmentedControl: UIGestureRecognizerDelegate {
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGestureRecognizer {
            return indicatorView.frame.contains(gestureRecognizer.location(in: self))
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}
