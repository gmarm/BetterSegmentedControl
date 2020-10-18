//
//  BetterSegmentedControl.swift
//
//  Created by George Marmaridis on 01/04/16.
//  Copyright © 2020 George Marmaridis. All rights reserved.
//

import UIKit

@IBDesignable open class BetterSegmentedControl: UIControl {
    open class IndicatorView: UIView {
        fileprivate let segmentMaskView = UIView()
        fileprivate var cornerRadius: CGFloat = 0.0 {
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
    
    // MARK: Properties
    // Public
    
    /// The selected index. Use `setIndex()` for setting the index.
    public private(set) var index: Int
    
    /// The segments available for selection.
    public var segments: [BetterSegmentedControlSegment] {
        didSet {
            update()
        }
    }
    
    /// The currently selected index indicator view.
    public let indicatorView = IndicatorView()
    
    /// Whether the the control should always send the .valueChanged event, regardless of the index remaining unchanged after interaction. Defaults to `false`.
    @IBInspectable public var alwaysAnnouncesValue: Bool = false
    
    /// Whether to send the .valueChanged event immediately or wait for animations to complete. Defaults to `true`.
    @IBInspectable public var announcesValueImmediately: Bool = true
    
    /// Whether the the control should ignore pan gestures. Defaults to `false`.
    @IBInspectable public var panningDisabled: Bool = false
    
    /// The control's and indicator's corner radii.
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            update()
        }
    }
    
    /// The indicator view's background color.
    @IBInspectable public var indicatorViewBackgroundColor: UIColor? {
        get {
            indicatorView.backgroundColor
        }
        set {
            indicatorView.backgroundColor = newValue
        }
    }
    
    /// The indicator view's inset. Defaults to `2.0`.
    @IBInspectable public var indicatorViewInset: CGFloat = 2.0 {
        didSet {
            update()
        }
    }
    
    /// The indicator view's border width.
    @IBInspectable public var indicatorViewBorderWidth: CGFloat {
        get {
            indicatorView.layer.borderWidth
        }
        set {
            indicatorView.layer.borderWidth = newValue
        }
    }
    
    /// The indicator view's border color.
    @IBInspectable public var indicatorViewBorderColor: UIColor? {
        get {
            guard let color = indicatorView.layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            indicatorView.layer.borderColor = newValue?.cgColor
        }
    }
    
    /// The duration of the animation of an index change. Defaults to `0.3`.
    @IBInspectable public var animationDuration: TimeInterval = 0.3
    
    /// The spring damping ratio of the animation of an index change. Defaults to `0.75`. Set to `1.0` for a no bounce effect.
    @IBInspectable public var animationSpringDamping: CGFloat = 0.75
    
    // Private
    private let normalSegmentsView = UIView()
    private let selectedSegmentsView = UIView()
    private var initialIndicatorViewFrame: CGRect?

    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    private var width: CGFloat { bounds.width }
    private var height: CGFloat { bounds.height }
    private var normalSegmentCount: Int { normalSegmentsView.subviews.count }
    private var normalSegments: [UIView] { normalSegmentsView.subviews }
    /// Views in `selectedSegments` also provide accessibility traits.
    private var selectedSegments: [UIView] { selectedSegmentsView.subviews }
    private var segmentViews: [UIView] { normalSegments + selectedSegments }
    private var lastIndex: Int { segments.endIndex - 1 }
    private var totalInsetSize: CGFloat { indicatorViewInset * 2.0 }
    private var isLayoutDirectionRightToLeft: Bool {
        let layoutDirection = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute)
        return layoutDirection == .rightToLeft
    }
    private static var defaultOptions: [Option] = [.backgroundColor(.appleSegmentedControlDefaultControlBackground),
                                                   .indicatorViewBackgroundColor(.appleSegmentedControlDefaultIndicatorBackground)]
    
    // MARK: Initialization
    
    /// Initializes a new `BetterSegmentedControl` with the parameters passed.
    ///
    /// - Parameters:
    ///   - frame: The frame of the control.
    ///   - segments: The segments to configure the control with.
    ///   - index: The initially selected index. Passing an index outside the segment indices will set the index to `0`.
    ///   - options: An array of customization options to style and change the behavior of the control.
    public init(frame: CGRect,
                segments: [BetterSegmentedControlSegment],
                index: Int = 0,
                options: [Option]? = nil) {
        if segments.indices.contains(index) {
            self.index = index
        } else {
            self.index = 0
        }
        
        self.segments = segments
        
        super.init(frame: frame)
        
        completeInit()
        
        setOptions(BetterSegmentedControl.defaultOptions)
        if let options = options {
            setOptions(options)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.index = 0
        self.segments = [LabelSegment(text: "First"), LabelSegment(text: "Second")]
        
        super.init(coder: aDecoder)
        
        completeInit()
    }
    
    @available(*, unavailable, message: "Use init(frame:segments:index:options:) instead.")
    convenience override public init(frame: CGRect) {
        self.init(frame: frame, segments: [LabelSegment(text: "First"), LabelSegment(text: "Second")])
    }
    
    @available(*, unavailable, message: "Use init(frame:segments:index:options:) instead.")
    convenience init() {
        self.init(frame: .zero, segments: [LabelSegment(text: "First"), LabelSegment(text: "Second")])
    }
    
    private func completeInit() {
        layer.masksToBounds = true
        
        // 1. add normalSegmentsView
        normalSegmentsView.clipsToBounds = true
        addSubview(normalSegmentsView)
        
        // 2. add indicatorView
        addSubview(indicatorView)
        selectedSegmentsView.clipsToBounds = true
        
        // 3. add selectedSegmentsView
        addSubview(selectedSegmentsView)
        selectedSegmentsView.layer.mask = indicatorView.segmentMaskView.layer
        
        // configure gestures
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
        
        update()
    }
    
    // MARK: View lifecycle
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        guard normalSegmentCount >= 1 else {
            return
        }
        
        normalSegmentsView.frame = bounds
        selectedSegmentsView.frame = bounds
        
        indicatorView.frame = frameForElement(atIndex: index)
        
        for index in 0...normalSegmentCount-1 {
            let frame = frameForElement(atIndex: index)
            normalSegmentsView.subviews[index].frame = frame
            selectedSegmentsView.subviews[index].frame = frame
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setDefaultLabelTextSegmentColorsFromInterfaceBuilder()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setDefaultLabelTextSegmentColorsFromInterfaceBuilder()
    }
    
    private func setDefaultLabelTextSegmentColorsFromInterfaceBuilder() {
        guard let normalLabelSegments = normalSegments as? [UILabel],
            let selectedLabelSegments = selectedSegments as? [UILabel] else {
                return
        }
        
        normalLabelSegments.forEach {
            $0.textColor = indicatorView.backgroundColor
        }
        selectedLabelSegments.forEach {
            $0.textColor = backgroundColor
        }
    }
    
    // MARK: Index Setting
    /// Sets the control's index. Setting an index outside the existing indices will not have any effect.
    ///
    /// - Parameters:
    ///   - index: The new index.
    ///   - animated: (Optional) Whether the change should be animated or not. Defaults to `true`.
    public func setIndex(_ index: Int, animated: Bool = true) {
        guard segments.indices.contains(index) else { return }
        
        let oldIndex = self.index
        self.index = index
        
        let shouldSendEvent = (index != oldIndex || alwaysAnnouncesValue)
        if announcesValueImmediately && shouldSendEvent {
            sendActions(for: .valueChanged)
            updateAccessibilityTraits()
        }
        
        moveIndicatorViewToIndex(animated: animated, completion: { [weak self] in
            guard let weakSelf = self else { return }
            
            if !weakSelf.announcesValueImmediately && shouldSendEvent {
                weakSelf.sendActions(for: .valueChanged)
                weakSelf.updateAccessibilityTraits()
            }
        })
    }
    
    // MARK: Option Setting
    /// A list of options to configure the control with.
    public func setOptions(_ options: [Option]) {
        for option in options {
            switch option {
            case let .indicatorViewBackgroundColor(value):
                indicatorViewBackgroundColor = value
            case let .indicatorViewInset(value):
                indicatorViewInset = value
            case let .indicatorViewBorderWidth(value):
                indicatorViewBorderWidth = value
            case let .indicatorViewBorderColor(value):
                indicatorViewBorderColor = value
            case let .alwaysAnnouncesValue(value):
                alwaysAnnouncesValue = value
            case let .announcesValueImmediately(value):
                announcesValueImmediately = value
            case let .panningDisabled(value):
                panningDisabled = value
            case let .backgroundColor(value):
                backgroundColor = value
            case let .cornerRadius(value):
                cornerRadius = value
            case let .animationDuration(value):
                animationDuration = value
            case let .animationSpringDamping(value):
                animationSpringDamping = value
            }
        }
    }
    
    // MARK: Animations
    private func moveIndicatorViewToIndex(animated: Bool, completion: @escaping () -> Void) {
        UIView.animate(withDuration: animated ? animationDuration : 0.0,
                       delay: 0.0,
                       usingSpringWithDamping: animationSpringDamping,
                       initialSpringVelocity: 0.0,
                       options: [.beginFromCurrentState, .curveEaseOut],
                       animations: { () -> Void in
                        self.indicatorView.frame = self.normalSegments[self.index].frame
                        self.layoutIfNeeded()
        }, completion: { finished -> Void in
            completion()
        })
    }
    
    // MARK: Helpers
    /// Updates the control and triggers a layout refresh.
    private func update() {
        func updateSegments() {
            normalSegmentsView.subviews.forEach { $0.removeFromSuperview() }
            selectedSegmentsView.subviews.forEach { $0.removeFromSuperview() }
            
            for segment in segments {
                segment.normalView.clipsToBounds = true
                segment.normalView.isAccessibilityElement = false
                
                segment.selectedView.clipsToBounds = true
                
                normalSegmentsView.addSubview(segment.normalView)
                selectedSegmentsView.addSubview(segment.selectedView)
            }
        }
        func updateCornerRadii() {
            indicatorView.cornerRadius = cornerRadius - indicatorViewInset
            segmentViews.forEach { $0.layer.cornerRadius = indicatorView.cornerRadius }
        }
        
        updateSegments()
        updateAccessibilityTraits()
        updateCornerRadii()
        
        setNeedsLayout()
    }
    private func updateAccessibilityTraits() {
        accessibilityElements = selectedSegments
        
        for (index, view) in selectedSegments.enumerated() {
            view.accessibilityTraits = (index == self.index ? [.button, .selected] : [.button])
        }
    }
    
    private func frameForElement(atIndex index: Int) -> CGRect {
        let elementWidth = (width - totalInsetSize) / CGFloat(normalSegmentCount)
        let x = CGFloat(isLayoutDirectionRightToLeft ? lastIndex - index : index) * elementWidth
        
        return CGRect(x: x + indicatorViewInset,
                      y: indicatorViewInset,
                      width: elementWidth,
                      height: height - totalInsetSize)
    }
    private func nearestIndex(toPoint point: CGPoint) -> Int {
        let distances = normalSegments.map { abs(point.x - $0.center.x) }
        return Int(distances.firstIndex(of: distances.min()!)!)
    }
    
    // MARK: Action handlers
    @objc private func tapped(_ gestureRecognizer: UITapGestureRecognizer!) {
        let location = gestureRecognizer.location(in: self)
        setIndex(nearestIndex(toPoint: location))
    }
    @objc private func panned(_ gestureRecognizer: UIPanGestureRecognizer!) {
        switch gestureRecognizer.state {
        case .began:
            initialIndicatorViewFrame = indicatorView.frame
        case .changed:
            var frame = initialIndicatorViewFrame!
            frame.origin.x += gestureRecognizer.translation(in: self).x
            frame.origin.x = max(min(frame.origin.x, bounds.width - indicatorViewInset - frame.width), indicatorViewInset)
            indicatorView.frame = frame
        case .ended, .failed, .cancelled:
            setIndex(nearestIndex(toPoint: indicatorView.center))
        default: break
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension BetterSegmentedControl: UIGestureRecognizerDelegate {
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGestureRecognizer {
            return indicatorView.frame.contains(gestureRecognizer.location(in: self)) && !panningDisabled
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}
