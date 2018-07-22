//
//  ViewController.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 04/03/2016.
//  Copyright (c) 2016 George Marmaridis. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class ViewController: UIViewController {
    
    @IBOutlet weak var control1: BetterSegmentedControl!
    @IBOutlet weak var control3: BetterSegmentedControl!
    
    // MARK: - Examples
    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 35.0, y: 40.0, width: 200.0, height: 30.0),
            segments: LabelSegment.segments(withTitles: ["Lights On", "Lights Off"],
                                            normalFont: UIFont(name: "Avenir", size: 13.0)!,
                                            normalTextColor: .lightGray,
                                            selectedFont: UIFont(name: "Avenir", size: 13.0)!,
                                            selectedTextColor: .white),
            options:[.backgroundColor(.darkGray),
                     .indicatorViewBackgroundColor(UIColor(red:0.55, green:0.26, blue:0.86, alpha:1.00)),
                     .cornerRadius(3.0),
                     .bouncesOnChange(false)])
        navigationSegmentedControl.addTarget(self, action: #selector(ViewController.navigationSegmentedControlValueChanged(_:)), for: .valueChanged)
        navigationItem.titleView = navigationSegmentedControl
        
        // Control 1: Created and designed in IB that announces its value on interaction
        control1.segments = LabelSegment.segments(withTitles: ["Recent", "Nearby", "All"],
                                                  normalFont: UIFont(name: "HelveticaNeue-Light", size: 13.0)!,
                                                  selectedFont: UIFont(name: "HelveticaNeue-Medium", size: 13.0)!)
        // Control 2: Exclusively defined in IB
        
        // Control 3: Many options
        control3.segments = LabelSegment.segments(withTitles: ["One","Two","Three","Four","Five","Six"],
                                                  normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                                                  selectedFont: UIFont(name: "HelveticaNeue-Medium", size: 14.0)!,
                                                  selectedTextColor: UIColor(red:0.20, green:0.68, blue:0.27, alpha:1.00))
        control3.setIndex(10, animated: false)
        
        // Control 4: Added as a subview
        let viewSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 332.0, width: view.bounds.width, height: 50.0),
            segments: LabelSegment.segments(withTitles: ["Artists", "Albums"],
                                            normalFont: UIFont(name: "HelveticaNeue", size: 16.0)!,
                                            normalTextColor: .white,
                                            selectedFont: UIFont(name: "HelveticaNeue", size: 16.0)!,
                                            selectedTextColor: UIColor(red:0.97, green:0.00, blue:0.24, alpha:1.00)),
            index: 1,
            options: [.backgroundColor(UIColor(red:0.11, green:0.12, blue:0.13, alpha:1.00)),
                      .indicatorViewBackgroundColor(UIColor(red:0.11, green:0.12, blue:0.13, alpha:1.00)),
                      .cornerRadius(0.0),
                      .bouncesOnChange(false),
                      .panningDisabled(true)])
        view.addSubview(viewSegmentedControl)
        
        // Control 5: Basic Icons
        let iconsSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 400.0, width: view.bounds.width/3, height: 30.0),
            segments: IconSegment.segments(withIcons: [#imageLiteral(resourceName: "facebook"), #imageLiteral(resourceName: "twitter")],
                                           iconSize: CGSize(width: 20.0, height: 20.0),
                                           normalIconTintColor: .white,
                                           selectedIconTintColor: UIColor(red:0.16, green:0.64, blue:0.94, alpha:1.00)),
            options: [.cornerRadius(15.0),
                      .backgroundColor(UIColor(red:0.16, green:0.64, blue:0.94, alpha:1.00)),
                      .indicatorViewBackgroundColor(.white)])
        view.addSubview(iconsSegmentedControl)
    }
    
    // MARK: - Action handlers
    @objc func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            print("Turning lights on.")
            view.backgroundColor = .white
        }
        else {
            print("Turning lights off.")
            view.backgroundColor = .darkGray
        }
    }
    
    @IBAction func segmentedControl1ValueChanged(_ sender: BetterSegmentedControl) {
        print("The selected index is \(sender.index)")
    }
}

