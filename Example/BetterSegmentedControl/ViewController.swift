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
    @IBOutlet weak var control2: BetterSegmentedControl!
    @IBOutlet weak var control3: BetterSegmentedControl!
    
    // MARK: - Examples
    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 0, y: 0, width: 200.0, height: 30.0),
            segments: LabelSegment.segments(withTitles: ["Lights On", "Lights Off"],
                                            normalTextColor: .lightGray,
                                            selectedTextColor: .white),
            options:[.backgroundColor(.darkGray),
                     .indicatorViewBackgroundColor(UIColor(red: 0.36, green: 0.38, blue: 0.87, alpha: 1.00)),
                     .cornerRadius(3.0),
                     .animationSpringDamping(1.0)])
        navigationSegmentedControl.addTarget(self,
                                             action: #selector(ViewController.navigationSegmentedControlValueChanged(_:)),
                                             for: .valueChanged)
        navigationItem.titleView = navigationSegmentedControl
        
        // Control 1: Created and designed in IB
        control1.segments = LabelSegment.segments(withTitles: ["Recent", "Nearby", "All"],
                                                  normalTextColor: UIColor(red: 0.48, green: 0.48, blue: 0.51, alpha: 1.00))
        
        // Control 2: Created and designed in IB
        control2.segments = LabelSegment.segments(withTitles: ["Music", "Movies", "Apps"],
                                                  normalTextColor: .white,
                                                  selectedTextColor: UIColor(red: 0.92, green: 0.29, blue: 0.15, alpha: 1.00))
        
        // Control 3: Many options
        control3.segments = LabelSegment.segments(withTitles: ["One", "Two", "Three", "Four", "Five"],
                                                  normalFont: .systemFont(ofSize: 14.0),
                                                  normalTextColor: UIColor(red: 0.15, green: 0.39, blue: 0.96, alpha: 0.9),
                                                  selectedFont: .systemFont(ofSize: 14.0),
                                                  selectedTextColor: UIColor(red: 0.16, green: 0.40, blue: 0.96, alpha: 1.00))
        
        // Control 4: Created and designed in IB, self-sizing
        
        // Control 5: Basic Icons
        let iconsSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 380.0, width: 160, height: 30.0),
            segments: IconSegment.segments(withIcons: [UIImage(named: "facebook")!, UIImage(named: "twitter")!],
                                           iconSize: CGSize(width: 20.0, height: 20.0),
                                           normalIconTintColor: .white,
                                           selectedIconTintColor: UIColor(red: 0.16, green: 0.64, blue: 0.94, alpha: 1.00)),
            options: [.cornerRadius(15.0),
                      .backgroundColor(UIColor(red: 0.16, green: 0.64, blue: 0.94, alpha: 1.00)),
                      .indicatorViewBackgroundColor(.white)])
        iconsSegmentedControl.center.x = view.center.x
        view.addSubview(iconsSegmentedControl)
        
        // Control 6: Apple style
        let appleStyledControl: BetterSegmentedControl = .appleStyled(frame: CGRect(x: 16.0,
                                                                                    y: 435,
                                                                                    width: view.bounds.width - 32.0,
                                                                                    height: 32.0),
                                                                      titles: ["First", "Second", "Third"])
        view.addSubview(appleStyledControl)
        
        // Control 7: No initially selected segment
        let noSelectedSegmentControl = BetterSegmentedControl(
            frame: CGRect(x: 16.0, y: 490, width: view.bounds.width - 32.0, height: 44.0),
            segments: LabelSegment.segments(withTitles: ["One", "Two", "Three", "Four"]),
            index: -1)
        noSelectedSegmentControl.addTarget(self, action: #selector(segmentedControl1ValueChanged(_:)), for: .valueChanged)
        view.addSubview(noSelectedSegmentControl)
    }
    
    // MARK: - Action handlers
    @objc func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            print("Turning lights on.")
            if #available(iOS 13.0, *) {
                view.backgroundColor = .systemGray5
            } else {
                view.backgroundColor = .white
            }
        } else {
            print("Turning lights off.")
            view.backgroundColor = .darkGray
        }
    }
    
    @IBAction func segmentedControl1ValueChanged(_ sender: BetterSegmentedControl) {
        print("The selected index is \(sender.index)")
    }
}
