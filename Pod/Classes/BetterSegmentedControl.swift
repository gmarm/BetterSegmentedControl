//
//  BetterSegmentedControl.swift
//
//  Created by George Marmaridis on 01/04/16.
//  Copyright © 2016 George Marmaridis. All rights reserved.
//

import UIKit

@IBDesignable open class BetterSegmentedControl: UIControl {
    open class IndicatorView: UIView {
        fileprivate let segmentMaskView = UIView()
        fileprivate var cornerRadius: CGFloat = 0 {
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
    /// The selected index.
    public private(set) var index: Int
    /// The segments available for selection.
    public var segments: [BetterSegmentedControlSegment] {
        didSet {
            guard segments.count > 1 else {
                return
            }
            
            normalSegmentsView.subviews.forEach({ $0.removeFromSuperview() })
            selectedSegmentsView.subviews.forEach({ $0.removeFromSuperview() })
            
            for segment in segments {
                normalSegmentsView.addSubview(segment.normalView)
                selectedSegmentsView.addSubview(segment.selectedView)
            }
            
            setNeedsLayout()
        }
    }
    
    /// The currently selected index indicator view.
    public let indicatorView = IndicatorView()
    
    /// A list of options to configure the control with.
    public var options: [BetterSegmentedControlOption]? {
        get { return nil }
        set {
            guard let options = newValue else {
                return
            }
            
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
    }
    /// Whether the the control should always send the .ValueChanged event, regardless of the index remaining unchanged after interaction. Defaults to `false`.
    @IBInspectable public var alwaysAnnouncesValue: Bool = false
    /// Whether to send the .ValueChanged event immediately or wait for animations to complete. Defaults to `true`.
    @IBInspectable public var announcesValueImmediately: Bool = true
    /// Whether the the control should ignore pan gestures. Defaults to `false`.
    @IBInspectable public var panningDisabled: Bool = false
    /// The control's and indicator's corner radii.
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            updateCornerRadii()
        }
    }
    /// The indicator view's background color.
    @IBInspectable public var indicatorViewBackgroundColor: UIColor? {
        get {
            return indicatorView.backgroundColor
        }
        set {
            indicatorView.backgroundColor = newValue
        }
    }
    /// The indicator view's inset. Defaults to `2.0`.
    @IBInspectable public var indicatorViewInset: CGFloat = 2.0 {
        didSet {
            updateCornerRadii()
            setNeedsLayout()
        }
    }
    /// The indicator view's border width.
    @IBInspectable public var indicatorViewBorderWidth: CGFloat {
        get {
            return indicatorView.layer.borderWidth
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
    
    private var width: CGFloat { return bounds.width }
    private var height: CGFloat { return bounds.height }
    private var normalSegmentCount: Int { return normalSegmentsView.subviews.count }
    private var normalSegments: [UIView] { return normalSegmentsView.subviews }
    private var selectedSegments: [UIView] { return selectedSegmentsView.subviews }
    private var segmentViews: [UIView] { return normalSegments + selectedSegments }
    private var totalInsetSize: CGFloat { return indicatorViewInset * 2.0 }
    private lazy var defaultSegments: [BetterSegmentedControlSegment] = {
        return [LabelSegment(text: "First"), LabelSegment(text: "Second")]
    }()
    private var isLayoutDirectionRightToLeft: Bool {
        let layoutDirection = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute)
        return layoutDirection == .rightToLeft
    }
    private var lastIndex: Int {
        return segments.endIndex - 1
    }
    
    // MARK: Lifecycle
    /// Initializes a new `BetterSegmentedControl` with the parameters passed.
    ///
    /// - Parameters:
    ///   - frame: The frame of the control.
    ///   - segments: The segments to configure the control with.
    ///   - index: The initially selected index.
    ///   - options: An array of customization options to style and change the behavior of the control.
    public init(frame: CGRect,
                segments: [BetterSegmentedControlSegment],
                index: Int = 0,
                options: [BetterSegmentedControlOption]? = nil) {
        self.index = index
        self.segments = segments
        super.init(frame: frame)
        completeInit()
        self.options = options
    }
    required public init?(coder aDecoder: NSCoder) {
        self.index = 0
        self.segments = [LabelSegment(text: "First"), LabelSegment(text: "Second")]
        super.init(coder: aDecoder)
        completeInit()
    }
    @available(*, unavailable, message: "Use init(frame:segments:index:options:) instead.")
    convenience override public init(frame: CGRect) {
        self.init(frame: frame,
                  segments: [LabelSegment(text: "First"), LabelSegment(text: "Second")])
    }
    @available(*, unavailable, message: "Use init(frame:segments:index:options:) instead.")
    convenience init() {
        self.init(frame: .zero,
                  segments: [LabelSegment(text: "First"), LabelSegment(text: "Second")])
    }
    private func completeInit() {
        layer.masksToBounds = true
        
        normalSegmentsView.clipsToBounds = true
        addSubview(normalSegmentsView)
        addSubview(indicatorView)
        selectedSegmentsView.clipsToBounds = true
        addSubview(selectedSegmentsView)
        selectedSegmentsView.layer.mask = indicatorView.segmentMaskView.layer
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BetterSegmentedControl.tapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(BetterSegmentedControl.panned(_:)))
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
        
        guard segments.count > 1 else { return }
        
        for segment in segments {
            segment.normalView.clipsToBounds = true
            normalSegmentsView.addSubview(segment.normalView)
            segment.selectedView.clipsToBounds = true
            selectedSegmentsView.addSubview(segment.selectedView)
        }
        
        setNeedsLayout()
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        guard normalSegmentCount > 1 else {
            return
        }
        
        normalSegmentsView.frame = bounds
        selectedSegmentsView.frame = bounds
        
        indicatorView.frame = elementFrame(forIndex: index)
        
        for index in 0...normalSegmentCount-1 {
            let frame = elementFrame(forIndex: index)
            normalSegmentsView.subviews[index].frame = frame
            selectedSegmentsView.subviews[index].frame = frame
        }
    }
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setDefaultLabelTextSegmentColorsFromInterfaceBuilder()
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
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
    /// Sets the control's index.
    ///
    /// - Parameters:
    ///   - index: The new index.
    ///   - animated: (Optional) Whether the change should be animated or not. Defaults to `true`.
    public func setIndex(_ index: Int, animated: Bool = true) {
        guard normalSegments.indices.contains(index) else { return }
        
        let oldIndex = self.index
        self.index = index
        moveIndicatorViewToIndex(animated, shouldSendEvent: (self.index != oldIndex || alwaysAnnouncesValue))
    }
    
    // MARK: Animations
    private func moveIndicatorViewToIndex(_ animated: Bool, shouldSendEvent: Bool) {
        if animated {
            if shouldSendEvent && announcesValueImmediately {
                sendActions(for: .valueChanged)
            }
            UIView.animate(withDuration: animationDuration,
                           delay: 0.0,
                           usingSpringWithDamping: animationSpringDamping,
                           initialSpringVelocity: 0.0,
                           options: [.beginFromCurrentState, .curveEaseOut],
                           animations: { () -> Void in
                            self.moveIndicatorView()
            }, completion: { finished -> Void in
                if finished && shouldSendEvent && !self.announcesValueImmediately {
                    self.sendActions(for: .valueChanged)
                }
            })
        } else {
            moveIndicatorView()

            if shouldSendEvent {
                sendActions(for: .valueChanged)
            }
        }
    }
    
    // MARK: Helpers
    private func elementFrame(forIndex index: Int) -> CGRect {
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
    private func moveIndicatorView() {
        indicatorView.frame = normalSegments[index].frame
        layoutIfNeeded()
    }
    private func updateCornerRadii() {
        indicatorView.cornerRadius = cornerRadius - indicatorViewInset
        segmentViews.forEach { $0.layer.cornerRadius = indicatorView.cornerRadius }
    }
    
    // MARK: Action handlers
    @objc private func tapped(_ gestureRecognizer: UITapGestureRecognizer!) {
        let location = gestureRecognizer.location(in: self)
        setIndex(nearestIndex(toPoint: location))
    }
    @objc private func panned(_ gestureRecognizer: UIPanGestureRecognizer!) {
        guard !panningDisabled else { return }
        
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
            return indicatorView.frame.contains(gestureRecognizer.location(in: self))
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}

extension BetterSegmentedControl {
    public class func appleStyled(frame: CGRect, titles: [String]) -> BetterSegmentedControl {
        let control = BetterSegmentedControl(
            frame: frame,
            segments: LabelSegment.segments(withTitles: titles,
                                            normalFont: .systemFont(ofSize: 13.0),
                                            normalTextColor: .black,
                                            selectedFont: .systemFont(ofSize: 13.0, weight: .medium),
                                            selectedTextColor: .black),
            index: 0,
            options: [.backgroundColor(UIColor(red: 238.0/255.0,
                                               green: 238.0/255.0,
                                               blue: 238.0/255.0,
                                               alpha: 1.0)),
                      .indicatorViewBackgroundColor(.white),
                      .cornerRadius(8),
                      .indicatorViewInset(2)])
        control.indicatorView.layer.shadowColor = UIColor.black.cgColor
        control.indicatorView.layer.shadowOpacity = 0.1
        control.indicatorView.layer.shadowOffset = CGSize(width: 1, height: 1)
        control.indicatorView.layer.shadowRadius = 2
        
        return control
    }
}
