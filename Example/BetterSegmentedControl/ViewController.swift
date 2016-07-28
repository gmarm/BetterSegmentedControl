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
    @IBOutlet weak var control4: BetterSegmentedControl!
    
    // MARK: - Examples
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BetterSegmentedControl as a navigation item
        let navigationSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 35.0, y: 40.0, width: 200.0, height: 30.0),
            titles: ["Lights On", "Lights Off"],
            index: 0,
            backgroundColor: .darkGrayColor(),
            titleColor: .lightGrayColor(),
            indicatorViewBackgroundColor: UIColor(red:0.55, green:0.26, blue:0.86, alpha:1.00),
            selectedTitleColor: .whiteColor())
        navigationSegmentedControl.cornerRadius = 3.0
        navigationSegmentedControl.titleFont = UIFont(name: "Avenir", size: 13.0)!
        navigationSegmentedControl.selectedTitleFont = UIFont(name: "Avenir", size: 13.0)!
        navigationSegmentedControl.bouncesOnChange = false
        navigationSegmentedControl.addTarget(self, action: #selector(ViewController.navigationSegmentedControlValueChanged(_:)), forControlEvents: .ValueChanged)
        navigationItem.titleView = navigationSegmentedControl
        
        // Control 1: Created and designed in IB that announces its value on interaction
        control1.titles = ["Recent","Nearby","All"]
        control1.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)!
        control1.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)!
        control1.alwaysAnnouncesValue = true
        print(control1.titles)
        
        // Control 2: Exclusively defined in IB
        
        // Control 3: Many options & error handling
        control3.titles = ["One","Two","Three","Four","Five","Six"]
        control3.titleFont = UIFont(name: "HelveticaNeue-Light", size: 14.0)!
        control3.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 14.0)!
        do {
            try control3.setIndex(10, animated: false)
        }
        catch BetterSegmentedControl.Error.IndexBeyondBounds(let invalidIndex) {
            print("Tried setting invalid index \(invalidIndex) to demonstrate error handling.")
        }
        catch {
            print("An error occured")
        }
        try! control3.setIndex(2, animated: false)
        
        // Control 4: Announce .ValueChanged immediately
        control4.titles = ["Quick","Fast","Brisk"]
        control4.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)!
        control4.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)!
        control4.announceImmediately = true
        
        // Control 5: Added as a subview
        let viewSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 376.0, width: view.bounds.width, height: 50.0),
            titles: ["Artists", "Albums"],
            index: 1,
            backgroundColor: UIColor(red:0.11, green:0.12, blue:0.13, alpha:1.00),
            titleColor: .whiteColor(),
            indicatorViewBackgroundColor: UIColor(red:0.11, green:0.12, blue:0.13, alpha:1.00),
            selectedTitleColor: UIColor(red:0.97, green:0.00, blue:0.24, alpha:1.00))
        viewSegmentedControl.autoresizingMask = [.FlexibleWidth]
        viewSegmentedControl.cornerRadius = 0.0
        viewSegmentedControl.titleFont = UIFont(name: "HelveticaNeue", size: 16.0)!
        viewSegmentedControl.selectedTitleFont = UIFont(name: "HelveticaNeue", size: 16.0)!
        viewSegmentedControl.bouncesOnChange = false
        viewSegmentedControl.panningDisabled = true
        view.addSubview(viewSegmentedControl)
    }
    
    // MARK: - Action handlers
    func navigationSegmentedControlValueChanged(sender: BetterSegmentedControl) {
        if sender.index == 0 {
            print("Turning lights on.")
            view.backgroundColor = .whiteColor()
        }
        else {
            print("Turning lights off.")
            view.backgroundColor = .darkGrayColor()
        }
    }
    
    @IBAction func segmentedControl1ValueChanged(sender: BetterSegmentedControl) {
        print("The selected index is \(sender.index) and the title is \(sender.titles[Int(sender.index)])")
    }
    
    @IBAction func segmentedControl4ValueChanged(sender: BetterSegmentedControl) {
        print("The selected index is \(sender.index) and the title is \(sender.titles[Int(sender.index)])")
    }
    
}

