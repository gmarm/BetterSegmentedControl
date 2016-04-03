//
//  BetterSegmentedControl.swift
//
//  Created by George Marmaridis on 01/04/16.
//  Copyright © 2016 George Marmaridis. All rights reserved.
//

import UIKit

// MARK: - BetterSegmentedControl
@IBDesignable public class BetterSegmentedControl: UIControl {
    // MARK: - Error handling
    public enum Error: ErrorType {
        case IndexBeyondBounds(UInt)
    }
    
    // MARK: - Constants
    private let animationWithBounceDuration: NSTimeInterval = 0.3
    private let animationWithBounceSpringDamping: CGFloat = 0.75
    private let animationNoBounceDuration: NSTimeInterval = 0.2
    
    // MARK: - Public properties
    /// The selected index
    public private(set) var index: UInt = 0
    /// The titles / options available for selection
    public var titles: [String] {
        get {
            let titleLabels = titleLabelsView.subviews as! [UILabel]
            return titleLabels.map{ $0.text! }
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
                titleLabel.lineBreakMode = .ByTruncatingTail
                titleLabel.textAlignment = .Center
                titleLabel.font = titleFont
                
                let selectedTitleLabel = UILabel()
                selectedTitleLabel.textColor = selectedTitleColor
                selectedTitleLabel.text = string
                selectedTitleLabel.lineBreakMode = .ByTruncatingTail
                selectedTitleLabel.textAlignment = .Center
                selectedTitleLabel.font = titleFont
                
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
    /// Whether the the control should always send the .ValueChanged event, regardless of the index remaining the same after interaction. Defaults to false.
    public var alwaysAnnouncesValue = false
    /// Whether the the control should respond to pan gestures. Defaults to false.
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
    @IBInspectable public var indicatorViewBackgroundColor: UIColor! {
        get { return indicatorView.backgroundColor }
        set { indicatorView.backgroundColor = newValue }
    }
    /// The indicator view's inset
    @IBInspectable public var indicatorViewInset: CGFloat = 2.0 {
        didSet { setNeedsLayout() }
    }
    /// The text color of the non-selected titles / options
    @IBInspectable public var titleColor: UIColor!  {
        didSet {
            if !titleLabels.isEmpty {
                for label in titleLabels {
                    label.textColor = titleColor
                }
            }
        }
    }
    /// The text color of the selected title / option
    @IBInspectable public var selectedTitleColor: UIColor! {
        didSet {
            if !selectedTitleLabels.isEmpty {
                for label in selectedTitleLabels {
                    label.textColor = selectedTitleColor
                }
            }
        }
    }
    /// The titles' font
    public var titleFont: UIFont! {
        didSet {
            if !allTitleLabels.isEmpty {
                for label in allTitleLabels {
                    label.font = titleFont
                }
            }
        }
    }
    
    // MARK: - Private properties
    private let titleLabelsView = UIView()
    private let selectedTitleLabelsView = UIView()
    private let indicatorView = IndicatorView()
    private var initialIndicatorViewFrame: CGRect?
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    private var width: CGFloat { return bounds.width }
    private var height: CGFloat { return bounds.height }
    private var titleLabelsCount: Int { return titleLabelsView.subviews.count }
    private var titleLabels: [UILabel] { return titleLabelsView.subviews as! [UILabel] }
    private var selectedTitleLabels: [UILabel] { return selectedTitleLabelsView.subviews as! [UILabel] }
    private var allTitleLabels: [UILabel] { return titleLabels + selectedTitleLabels }
    private var totalInsetSize: CGFloat { return indicatorViewInset * 2.0 }
    private lazy var defaultTitles: [String] = { return ["First", "Second"] }()
    
    // MARK: - Lifecycle
    public init(titles: [String]) {
        super.init(frame: CGRect.zero)
        self.titles = titles
        finishInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        titles = defaultTitles
        finishInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        titles = defaultTitles
        finishInit()
    }
    
    private func finishInit() {
        layer.masksToBounds = true
        
        addSubview(titleLabelsView)
        addSubview(indicatorView)
        addSubview(selectedTitleLabelsView)
        selectedTitleLabelsView.layer.mask = indicatorView.titleMaskView.layer
        
        titleColor = .whiteColor()
        indicatorViewBackgroundColor = .whiteColor()
        selectedTitleColor = .blackColor()
        titleFont = UILabel().font
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BetterSegmentedControl.tapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(BetterSegmentedControl.pan(_:)))
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        guard titleLabelsCount > 1 else {
            return
        }
        
        titleLabelsView.frame = bounds
        selectedTitleLabelsView.frame = bounds
        
        indicatorView.frame = elementFrameForIndex(index)
        
        for index in 0...titleLabelsCount-1 {
            let frame = elementFrameForIndex(UInt(index))
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
    public func setIndex(index: UInt, animated: Bool = true) throws {
        guard titleLabels.indices.contains(Int(index)) else {
            throw Error.IndexBeyondBounds(index)
        }
        let oldIndex = self.index
        self.index = index
        moveIndicatorViewToIndexAnimated(animated, shouldSendEvent: (self.index != oldIndex || alwaysAnnouncesValue))
    }
    
    // MARK: - Animations
    private func moveIndicatorViewToIndexAnimated(animated: Bool, shouldSendEvent: Bool) {
        if animated {
            UIView.animateWithDuration(bouncesOnChange ? animationWithBounceDuration : animationNoBounceDuration,
                                       delay: 0.0,
                                       usingSpringWithDamping: bouncesOnChange ? animationWithBounceSpringDamping : 1.0,
                                       initialSpringVelocity: 0.0,
                                       options: [UIViewAnimationOptions.BeginFromCurrentState, UIViewAnimationOptions.CurveEaseOut],
                                       animations: {
                                        () -> Void in
                                        self.moveIndicatorView()
                }, completion: { (finished) -> Void in
                    if finished && shouldSendEvent {
                        self.sendActionsForControlEvents(.ValueChanged)
                    }
            })
        }
        else {
            moveIndicatorView()
            self.sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    // MARK: - Helpers
    private func elementFrameForIndex(index: UInt) -> CGRect {
        let elementWidth = (width - totalInsetSize) / CGFloat(titleLabelsCount)
        return CGRect(x: CGFloat(index) * elementWidth + indicatorViewInset,
                      y: indicatorViewInset,
                      width: elementWidth,
                      height: height - totalInsetSize)
    }
    
    private func nearestIndexToPoint(point: CGPoint) -> UInt {
        let distances = titleLabels.map { abs(point.x - $0.center.x) }
        return UInt(distances.indexOf(distances.minElement()!)!)
    }
    
    private func moveIndicatorView() {
        self.indicatorView.frame = self.titleLabels[Int(self.index)].frame
        self.layoutIfNeeded()
    }
    
    // MARK: - Action handlers
    @objc private func tapped(gestureRecognizer: UITapGestureRecognizer!) {
        let location = gestureRecognizer.locationInView(self)
        try! setIndex(nearestIndexToPoint(location))
    }
    
    @objc private func pan(gestureRecognizer: UIPanGestureRecognizer!) {
        guard !panningDisabled else {
            return
        }
    
        switch gestureRecognizer.state {
        case .Began:
            initialIndicatorViewFrame = indicatorView.frame
        case .Changed:
            var frame = initialIndicatorViewFrame!
            frame.origin.x += gestureRecognizer.translationInView(self).x
            frame.origin.x = max(min(frame.origin.x, bounds.width - indicatorViewInset - frame.width), indicatorViewInset)
            indicatorView.frame = frame
        case .Ended, .Failed, .Cancelled:
            try! setIndex(nearestIndexToPoint(indicatorView.center))
        default: break
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension BetterSegmentedControl: UIGestureRecognizerDelegate {
    
    override public func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGestureRecognizer {
            return indicatorView.frame.contains(gestureRecognizer.locationInView(self))
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}

// MARK: - IndicatorView
private class IndicatorView: UIView {
    
    // MARK: - Properties
    private let titleMaskView = UIView()
    
    private var cornerRadius: CGFloat! {
        didSet {
            layer.cornerRadius = cornerRadius
            titleMaskView.layer.cornerRadius = cornerRadius
        }
    }
    
    override var frame: CGRect {
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
    
    private func finishInit() {
        layer.masksToBounds = true
        titleMaskView.backgroundColor = .blackColor()
    }
}
