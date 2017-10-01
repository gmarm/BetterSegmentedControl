//
//  BetterSegmentedControl.swift
//
//  Created by George Marmaridis on 01/04/16.
//  Copyright © 2016 George Marmaridis. All rights reserved.
//

import UIKit

// MARK: - BetterSegmentedControl
@IBDesignable open class BetterSegmentedControl: UIControl {
    // MARK: IndicatorView
    fileprivate class IndicatorView: UIView {
        // MARK: Properties
        fileprivate let titleMaskView = UIView()
        fileprivate var cornerRadius: CGFloat = 0 {
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
        
        // MARK: Lifecycle
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
    
    // MARK: Constants
    fileprivate struct Animation {
        fileprivate static let withBounceDuration: TimeInterval = 0.3
        fileprivate static let springDamping: CGFloat = 0.75
        fileprivate static let withoutBounceDuration: TimeInterval = 0.2
    }
    fileprivate struct Color {
        fileprivate static let background: UIColor = UIColor.white
        fileprivate static let title: UIColor = UIColor.black
        fileprivate static let indicatorViewBackground: UIColor = UIColor.black
        fileprivate static let selectedTitle: UIColor = UIColor.white
    }
    
    // MARK: Error handling
    public enum IndexError: Error {
        case indexBeyondBounds(UInt)
    }
    
    // MARK: Properties
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
                titleLabel.layer.borderWidth = titleBorderWidth
                titleLabel.layer.borderColor = titleBorderColor.cgColor
                titleLabel.layer.cornerRadius = indicatorView.cornerRadius
                titleLabel.numberOfLines = titleNumberOfLines
                
                let selectedTitleLabel = UILabel()
                selectedTitleLabel.textColor = selectedTitleColor
                selectedTitleLabel.text = string
                selectedTitleLabel.lineBreakMode = .byTruncatingTail
                selectedTitleLabel.textAlignment = .center
                selectedTitleLabel.font = selectedTitleFont
                selectedTitleLabel.numberOfLines = titleNumberOfLines
                
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
    public var options: [BetterSegmentedControlOption]? {
        get { return nil }
        set {
            guard let options = newValue else {
                return
            }
            for option in options {
                switch option {
                case let .titleColor(value):
                    titleColor = value
                case let .titleFont(value):
                    titleFont = value
                case let .selectedTitleColor(value):
                    selectedTitleColor = value
                case let .selectedTitleFont(value):
                    selectedTitleFont = value
                case let .titleBorderWidth(value):
                    titleBorderWidth = value
                case let .titleBorderColor(value):
                    titleBorderColor = value
                case let .titleNumberOfLines(value):
                    titleNumberOfLines = value
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
                case let .bouncesOnChange(value):
                    bouncesOnChange = value
                }
            }
        }
    }
    
    /// Whether the indicator should bounce when selecting a new index. Defaults to true
    @IBInspectable public fileprivate(set) var bouncesOnChange: Bool = true
    /// Whether the the control should always send the .ValueChanged event, regardless of the index remaining unchanged after interaction. Defaults to false
    @IBInspectable public fileprivate(set) var alwaysAnnouncesValue: Bool = false
    /// Whether to send the .ValueChanged event immediately or wait for animations to complete. Defaults to true
    @IBInspectable public fileprivate(set) var announcesValueImmediately: Bool = true
    /// Whether the the control should ignore pan gestures. Defaults to false
    @IBInspectable public fileprivate(set) var panningDisabled: Bool = false
    /// The control's and indicator's corner radii
    @IBInspectable public fileprivate(set) var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            indicatorView.cornerRadius = newValue - indicatorViewInset
            titleLabels.forEach { $0.layer.cornerRadius = indicatorView.cornerRadius }
        }
    }
    /// The indicator view's background color
    @IBInspectable fileprivate(set) public var indicatorViewBackgroundColor: UIColor? {
        get {
            return indicatorView.backgroundColor
        }
        set {
            indicatorView.backgroundColor = newValue
        }
    }
    /// The indicator view's inset. Defaults to 2.0
    @IBInspectable public fileprivate(set) var indicatorViewInset: CGFloat = 2.0 {
        didSet { setNeedsLayout() }
    }
    /// The indicator view's border width
    @IBInspectable public fileprivate(set) var indicatorViewBorderWidth: CGFloat {
        get {
            return indicatorView.layer.borderWidth
        }
        set {
            indicatorView.layer.borderWidth = newValue
        }
    }
    /// The indicator view's border color
    @IBInspectable public fileprivate(set) var indicatorViewBorderColor: UIColor? {
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
    /// The text color of the non-selected titles / options
    @IBInspectable public fileprivate(set) var titleColor: UIColor = Color.title  {
        didSet {
            titleLabels.forEach { $0.textColor = titleColor }
        }
    }
    /// The text color of the selected title / option
    @IBInspectable public fileprivate(set) var selectedTitleColor: UIColor = Color.selectedTitle {
        didSet {
            selectedTitleLabels.forEach { $0.textColor = selectedTitleColor }
        }
    }
    /// The titles' font
    public var titleFont: UIFont = UILabel().font {
        didSet {
            titleLabels.forEach { $0.font = titleFont }
        }
    }
    /// The selected title's font
    public var selectedTitleFont: UIFont = UILabel().font {
        didSet {
            selectedTitleLabels.forEach { $0.font = selectedTitleFont }
        }
    }
    /// The titles' border width
    @IBInspectable public fileprivate(set) var titleBorderWidth: CGFloat = 0.0 {
        didSet {
            titleLabels.forEach { $0.layer.borderWidth = titleBorderWidth }
        }
    }
    /// The titles' number of lines
    @IBInspectable public fileprivate(set) var titleNumberOfLines: Int = 1 {
        didSet {
            titleLabels.forEach { $0.numberOfLines = titleNumberOfLines }
            selectedTitleLabels.forEach { $0.numberOfLines = titleNumberOfLines }
        }
    }
    /// The titles' border color
    @IBInspectable public fileprivate(set) var titleBorderColor: UIColor = UIColor.clear {
        didSet {
            titleLabels.forEach { $0.layer.borderColor = titleBorderColor.cgColor }
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
    
    // MARK: Lifecycle
    required public init?(coder aDecoder: NSCoder) {
        self.index = 0
        super.init(coder: aDecoder)
        self.titles = defaultTitles
        finishInit()
    }
    public init(frame: CGRect,
                titles: [String],
                index: UInt = 0,
                options: [BetterSegmentedControlOption]? = nil) {
        self.index = index
        super.init(frame: frame)
        self.titles = titles
        self.options = options
        finishInit()
    }
    @available(*, deprecated, message: "Use init(frame:titles:index:options:) instead.")
    convenience override public init(frame: CGRect) {
        self.init(frame: frame,
                  titles: ["First", "Second"],
                  index: 0,
                  options: [.backgroundColor(Color.background),
                            .titleColor(Color.title),
                            .indicatorViewBackgroundColor(Color.indicatorViewBackground),
                            .selectedTitleColor(Color.selectedTitle)])
    }

    @available(*, unavailable, message: "Use init(frame:titles:index:options:) instead.")
    convenience init() {
        self.init(frame: CGRect.zero,
                  titles: ["First", "Second"],
                  index: 0,
                  options: [.backgroundColor(Color.background),
                            .titleColor(Color.title),
                            .indicatorViewBackgroundColor(Color.indicatorViewBackground),
                            .selectedTitleColor(Color.selectedTitle)])
    }
    fileprivate func finishInit() {
        layer.masksToBounds = true
        
        addSubview(titleLabelsView)
        addSubview(indicatorView)
        addSubview(selectedTitleLabelsView)
        selectedTitleLabelsView.layer.mask = indicatorView.titleMaskView.layer
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BetterSegmentedControl.tapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(BetterSegmentedControl.panned(_:)))
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
    
    // MARK: Index Setting
    /**
     Sets the control's index.
     
     - parameter index:    The new index
     - parameter animated: (Optional) Whether the change should be animated or not. Defaults to true.
     
     - throws: An error of type IndexBeyondBounds(UInt) is thrown if an index beyond the available indices is passed.
     */
    public func setIndex(_ index: UInt, animated: Bool = true) throws {
        guard titleLabels.indices.contains(Int(index)) else {
            throw IndexError.indexBeyondBounds(index)
        }
        let oldIndex = self.index
        self.index = index
        moveIndicatorViewToIndex(animated, shouldSendEvent: (self.index != oldIndex || alwaysAnnouncesValue))
    }

    // MARK: Indicator View Customization

    /**
     Adds the passed view as a subview to the indicator view
     
     - parameter view: The view to be added to the indicator view
     
     - note: The added view must be able to layout & size itself and will not be autoresized.
     */
    public func addSubviewToIndicator(_ view: UIView) {
        indicatorView.addSubview(view)
    }
    
    // MARK: Animations
    fileprivate func moveIndicatorViewToIndex(_ animated: Bool, shouldSendEvent: Bool) {
        if animated {
            if shouldSendEvent && announcesValueImmediately {
                sendActions(for: .valueChanged)
            }
            UIView.animate(withDuration: bouncesOnChange ? Animation.withBounceDuration : Animation.withoutBounceDuration,
                           delay: 0.0,
                           usingSpringWithDamping: bouncesOnChange ? Animation.springDamping : 1.0,
                           initialSpringVelocity: 0.0,
                           options: [UIViewAnimationOptions.beginFromCurrentState, UIViewAnimationOptions.curveEaseOut],
                           animations: {
                            () -> Void in
                            self.moveIndicatorView()
            }, completion: { (finished) -> Void in
                if finished && shouldSendEvent && !self.announcesValueImmediately {
                    self.sendActions(for: .valueChanged)
                }
            })
        } else {
            moveIndicatorView()
            sendActions(for: .valueChanged)
        }
    }
    
    // MARK: Helpers
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
        indicatorView.frame = titleLabels[Int(self.index)].frame
        layoutIfNeeded()
    }
    
    // MARK: Action handlers
    @objc fileprivate func tapped(_ gestureRecognizer: UITapGestureRecognizer!) {
        let location = gestureRecognizer.location(in: self)
        try! setIndex(nearestIndex(toPoint: location))
    }
    @objc fileprivate func panned(_ gestureRecognizer: UIPanGestureRecognizer!) {
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
            try! setIndex(nearestIndex(toPoint: indicatorView.center))
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
