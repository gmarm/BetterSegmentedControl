//
//  BetterSegmentedControl.swift
//
//  Created by George Marmaridis on 01/04/16.
//  Copyright © 2020 George Marmaridis. All rights reserved.
//

#if canImport(UIKit)

import UIKit

@IBDesignable open class BetterSegmentedControl: UIControl {
    private struct Constants {
        static let minimumIntrinsicContentSizeHeight: CGFloat = 32.0
        static let minimumSegmentIntrinsicContentSizeWidth: CGFloat = 20.0
    }
    
    // MARK: Properties
    
    // Public
    /// Indicates a no-segment-selected state.
    public static let noSegment = -1
    
    /// The selected index. Use `setIndex()` for setting the index.
    public private(set) var index: Int
    
    /// The segments available for selection.
    public var segments: [BetterSegmentedControlSegment] {
        didSet {
            applySegments()
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
            updateCornerRadii()
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
            updateCornerRadii()
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
    
    /// When the control auto-sizes itself, this controls the additional side padding between the segments.
    @IBInspectable public var segmentPadding: CGFloat = 14.0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        let segmentIntrinsicContentSizes = segments.map {
            $0.intrinsicContentSize ?? .zero
        }
        
        let maxSegmentIntrinsicContentSizeWidth = segmentIntrinsicContentSizes.max(by: { (a, b) in
            return a.width < b.width
        })?.width ?? 0.0
        
        let maxSegmentIntrinsicContentSizeHeight = segmentIntrinsicContentSizes.max(by: { (a, b) in
            return a.height < b.height
        })?.height ?? 0.0
        
        let singleSegmentWidth = totalInsetSize + max(maxSegmentIntrinsicContentSizeWidth, Constants.minimumSegmentIntrinsicContentSizeWidth) + segmentPadding
        
        let width = ceil(CGFloat(segments.count) * singleSegmentWidth)
        let height = ceil(max(maxSegmentIntrinsicContentSizeHeight + totalInsetSize, Constants.minimumIntrinsicContentSizeHeight))
        
        return .init(width: width, height: height)
    }
    
    // Private
    private let normalSegmentViewsContainerView = UIView()
    private let selectedSegmentViewsContainerView = UIView()
    private let pointerInteractionViewsContainerView = UIView()
    
    private var initialIndicatorViewFrame: CGRect?

    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    private var normalSegmentViews: [UIView] = []
    private var normalSegmentViewCount: Int { normalSegmentViews.count }
    
    /// `selectedSegmentViews` provide accessibility traits.
    private var selectedSegmentViews: [UIView] = []
    
    var pointerInteractionViews: [UIView] = []
    /// Used for iPad Pointer Interaction support. Holds the reference to the view that should be highlighted, if any.
    weak var pointerInteractionView: UIView?
    
    /// Contains normal segment views, selected segment views and pointer interaction views.
    private var allSegmentViews: [UIView] { normalSegmentViews + selectedSegmentViews + pointerInteractionViews }
    
    private var safeIndex: Int {
        index >= 0 ? index : 0
    }
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
    ///   - index: The initially selected index. Passing `BetterSegmentedControl.noSegment` sets the index to `-1` and hides the
    ///   indicator view. Passing an index beyond the segment indices will set the index to `0`.
    ///   - options: An array of customization options to style and change the behavior of the control.
    public init(frame: CGRect,
                segments: [BetterSegmentedControlSegment],
                index: Int = 0,
                options: [Option]? = nil) {
        if segments.indices.contains(index) || index == Self.noSegment {
            self.index = index
        } else {
            self.index = 0
        }
        
        self.segments = segments
        
        super.init(frame: frame)
        
        completeInit()
        
        if index == -1 {
            setIndicatorViewVisible(false, animated: false, completion: nil)
        }
        
        setOptions(BetterSegmentedControl.defaultOptions)
        if let options = options {
            setOptions(options)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.index = 0
        self.segments = Self.generateDefaultSegments()
        
        super.init(coder: aDecoder)
        
        completeInit()
    }
    
    convenience override public init(frame: CGRect) {
        self.init(frame: frame, segments: Self.generateDefaultSegments())
    }
    
    convenience init() {
        self.init(frame: .zero, segments: Self.generateDefaultSegments())
    }
    
    private func completeInit() {
        layer.masksToBounds = true
        
        if #available(iOS 13.4, *) {
            let interaction = UIPointerInteraction(delegate: self)
            addInteraction(interaction)
        }
        
        // set up view hierarchy
        normalSegmentViewsContainerView.clipsToBounds = true
        addSubview(normalSegmentViewsContainerView)
        
        addSubview(indicatorView)
        
        selectedSegmentViewsContainerView.clipsToBounds = true
        addSubview(selectedSegmentViewsContainerView)
        selectedSegmentViewsContainerView.layer.mask = indicatorView.segmentMaskView.layer
        
        pointerInteractionViewsContainerView.clipsToBounds = true
        addSubview(pointerInteractionViewsContainerView)
        
        // configure gestures
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
        
        applySegments(shouldResetIndex: false)
    }
    
    // MARK: View lifecycle
    override open func layoutSubviews() {
        super.layoutSubviews()
        guard normalSegmentViewCount >= 1 else {
            return
        }
        
        normalSegmentViewsContainerView.frame = bounds
        selectedSegmentViewsContainerView.frame = bounds
        pointerInteractionViewsContainerView.frame = bounds
        
        indicatorView.frame = frameForElement(atIndex: safeIndex)
        
        for (index, _) in normalSegmentViews.enumerated() {
            let frame = frameForElement(atIndex: index)
            normalSegmentViews[index].frame = frame
            selectedSegmentViews[index].frame = frame
            pointerInteractionViews[index].frame = frame
        }
    }

    // MARK: Index Setting
    /// Sets the control's index.
    ///
    /// - Parameters:
    ///   - index: The new index. Passing `BetterSegmentedControl.noSegment` sets the index to `-1` and hides the indicator view.
    ///   Passing an index beyond the segment indices will have no effect.
    ///   - animated: Whether the change should be animated or not. Defaults to `true`.
    ///   - shouldSendValueChangedEvent: Whether the index change should trigger a `.valueChanged` event or not. Defaults to
    ///   `false`. This takes precedence over `alwaysAnnouncesValue`.
    public func setIndex(_ index: Int, animated: Bool = true, shouldSendValueChangedEvent: Bool = false) {
        guard segments.indices.contains(index) || index == Self.noSegment else { return }
        
        let previousIndex = self.index
        self.index = index
        
        let shouldUpdateSegmentViewTraits = (index != previousIndex)
        let shouldUpdateSegmentViewTraitsBeforeAnimations = announcesValueImmediately && shouldUpdateSegmentViewTraits
        let shouldUpdateSegmentViewTraitsAfterAnimations = !announcesValueImmediately && shouldUpdateSegmentViewTraits
        
        let shouldSendEvent = (index != previousIndex || alwaysAnnouncesValue) && shouldSendValueChangedEvent
        let shouldSendEventBeforeAnimations = announcesValueImmediately && shouldSendEvent
        let shouldSendEventAfterAnimations = !announcesValueImmediately && shouldSendEvent
        
        if shouldSendEventBeforeAnimations {
            sendActions(for: .valueChanged)
        }
        if shouldUpdateSegmentViewTraitsBeforeAnimations {
            updateSegmentViewTraits()
        }
        performIndexChange(fromPreviousIndex: previousIndex, toNewIndex: index, animated: animated, completion: { [weak self] in
            guard let weakSelf = self else { return }
            
            if shouldSendEventAfterAnimations {
                weakSelf.sendActions(for: .valueChanged)
            }
            if shouldUpdateSegmentViewTraitsAfterAnimations {
                weakSelf.updateSegmentViewTraits()
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
    /// Hides the indicator and selected segments view.
    private func setIndicatorViewVisible(_ isVisible: Bool, animated: Bool, completion: (() -> Void)?) {
        UIView.animate(withDuration: (animated ? 0.1 : 0.0),
                       delay: 0.0,
                       options: [.beginFromCurrentState, .curveEaseIn],
                       animations: { () -> Void in
                        self.selectedSegmentViewsContainerView.alpha = isVisible ? 1.0 : 0.0
                        self.indicatorView.alpha = isVisible ? 1.0 : 0.0
        }, completion: { finished -> Void in
            completion?()
        })
    }
    
    private func performIndexChange(fromPreviousIndex previousIndex: Int,
                                    toNewIndex newIndex: Int,
                                    animated: Bool,
                                    completion: @escaping () -> Void) {
        func moveIndicatorViewToIndex(animated: Bool, completion: @escaping () -> Void) {
            guard index >= 0 else { return }
            
            UIView.animate(withDuration: animated ? animationDuration : 0.0,
                           delay: 0.0,
                           usingSpringWithDamping: animationSpringDamping,
                           initialSpringVelocity: 0.0,
                           options: [.beginFromCurrentState, .curveEaseOut],
                           animations: { () -> Void in
                            self.indicatorView.frame = self.normalSegmentViews[self.index].frame
                            self.layoutIfNeeded()
            }, completion: { finished -> Void in
                completion()
            })
        }
        
        if index == Self.noSegment {
            setIndicatorViewVisible(false, animated: animated) {
                completion()
            }
        } else if previousIndex == Self.noSegment {
            moveIndicatorViewToIndex(animated: false, completion: { [weak self] in
                self?.setIndicatorViewVisible(true, animated: animated) {
                    completion()
                }
            })
        } else {
            moveIndicatorViewToIndex(animated: animated, completion: {
                completion()
            })
        }
    }
    
    // MARK: Helpers
    /// Updates the segments and triggers a layout refresh. Resets the index if needed.
    private func applySegments(shouldResetIndex: Bool = true) {
        normalSegmentViews.forEach { $0.removeFromSuperview() }
        normalSegmentViews.removeAll()
        
        selectedSegmentViews.forEach { $0.removeFromSuperview() }
        selectedSegmentViews.removeAll()
        
        pointerInteractionViews.forEach { $0.removeFromSuperview() }
        pointerInteractionViews.removeAll()
        
        for segment in segments {
            segment.normalView.clipsToBounds = true
            segment.normalView.isAccessibilityElement = false
            
            segment.selectedView.clipsToBounds = true
            
            normalSegmentViewsContainerView.addSubview(segment.normalView)
            normalSegmentViews.append(segment.normalView)
            
            selectedSegmentViewsContainerView.addSubview(segment.selectedView)
            selectedSegmentViews.append(segment.selectedView)
            
            let pointerInteractionView = UIView()
            pointerInteractionViewsContainerView.addSubview(pointerInteractionView)
            pointerInteractionViews.append(pointerInteractionView)
        }
        
        updateSegmentViewTraits()
        updateCornerRadii()
        if shouldResetIndex {
            resetIndex()
        }
        
        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }
    
    private func updateCornerRadii() {
        indicatorView.cornerRadius = cornerRadius - indicatorViewInset
        allSegmentViews.forEach { $0.layer.cornerRadius = indicatorView.cornerRadius }
    }
    
    private func updateSegmentViewTraits() {
        accessibilityElements = selectedSegmentViews
        
        for (index, _) in selectedSegmentViews.enumerated() {
            selectedSegmentViews[index].accessibilityTraits = (index == self.index ? [.button, .selected] : [.button])
        }
    }
    
    private func frameForElement(atIndex index: Int) -> CGRect {
        let elementWidth = (width - totalInsetSize) / CGFloat(normalSegmentViewCount)
        let x = CGFloat(isLayoutDirectionRightToLeft ? lastIndex - index : index) * elementWidth
        
        return CGRect(x: x + indicatorViewInset,
                      y: indicatorViewInset,
                      width: elementWidth,
                      height: height - totalInsetSize)
    }
    
    private func resetIndex() {
        let newIndex = (segments.count > 0 ? 0 : -1)
        setIndex(newIndex, animated: false, shouldSendValueChangedEvent: false)
    }
    
    func closestIndex(toPoint point: CGPoint) -> Int {
        let distances = normalSegmentViews.map { abs(point.x - $0.center.x) }
        return Int(distances.firstIndex(of: distances.min()!)!)
    }
    
    private static func generateDefaultSegments() -> [LabelSegment] {
        [.init(text: "First"), .init(text: "Second"), .init(text: "Third")]
    }
    
    // MARK: Action handlers
    @objc private func tapped(_ gestureRecognizer: UITapGestureRecognizer!) {
        let location = gestureRecognizer.location(in: self)
        setIndex(closestIndex(toPoint: location), shouldSendValueChangedEvent: true)
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
            setIndex(closestIndex(toPoint: indicatorView.center), shouldSendValueChangedEvent: true)
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

#endif
