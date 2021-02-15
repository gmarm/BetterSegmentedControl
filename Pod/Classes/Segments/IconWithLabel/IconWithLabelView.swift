//
//  IconWithLabelView.swift
//  BetterSegmentedControl
//
//  Created by Arman Zoghi on 2/14/21.
//

import UIKit

class IconWithLabelView: UIView {
    // MARK: Subviews
    public var imageView: UIImageView?
    public var label: UILabel?
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Image View
    //config
    public func imageViewConfig(icon: UIImage, width: CGFloat, height: CGFloat, contentMode: UIView.ContentMode, tintColor: UIColor) {
        self.imageView = UIImageView(image: icon)
        self.imageView?.tintColor = tintColor
        self.addSubview(self.imageView!)
        self.imageViewConstraints(width: width, height: height)
    }
    //constraints
    fileprivate func imageViewConstraints(width: CGFloat, height: CGFloat) {
        self.imageView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.imageView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.65, constant: 0).isActive = true
        NSLayoutConstraint(item: self.imageView!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.imageView!, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: width).isActive = true
        NSLayoutConstraint(item: self.imageView!, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: height).isActive = true
    }
    
    // MARK: Label
    //config
    func labelConfig(text: String?, numberOfLines: Int?, font: UIFont?, textColor: UIColor?, lineBreakMode: NSLineBreakMode, textAlignment: NSTextAlignment, accessibilityIdentifier: String?) {
        self.label = UILabel()
        self.addSubview(self.label!)
        self.labelConstraints()
        self.label?.sizeToFit()
        self.label?.text = text
        self.label?.numberOfLines = numberOfLines ?? 1
        self.label?.font = font
        self.label?.textColor = textColor
        self.label?.lineBreakMode = lineBreakMode
        self.label?.textAlignment = textAlignment
        self.label?.accessibilityIdentifier = accessibilityIdentifier
    }
    //constraints
    fileprivate func labelConstraints() {
        self.label!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.label!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.65, constant: 0).isActive = true
        NSLayoutConstraint(item: self.label!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.label!, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0).isActive = true
    }
    
}
