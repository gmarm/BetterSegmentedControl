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

    enum LightMode: String {
        //enum values are the same as what's expected in the request API
        case Off = "Lights Off"
        case On = "Lights On"
        
        static let allValues = [On, Off]
        static let allValuesString = [On.rawValue, Off.rawValue]
        
    }
    
    @IBOutlet weak var control1: BetterSegmentedControl!
    @IBOutlet weak var control3: BetterSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // As a navigation item
        let navigationSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 35.0, y: 40.0, width: 200.0, height: 30.0),
            titles: LightMode.allValuesString,
            index: 0,
            backgroundColor: .darkGrayColor(),
            titleColor: .lightGrayColor(),
            indicatorViewBackgroundColor: UIColor(red:0.55, green:0.26, blue:0.86, alpha:1.00),
            selectedTitleColor: .whiteColor())
        navigationSegmentedControl.cornerRadius = 3.0
        navigationSegmentedControl.titleFont = UIFont(name: "Avenir", size: 13.0)!
        navigationSegmentedControl.bouncesOnChange = false
        navigationSegmentedControl.addTarget(self, action: Selector("navigationSegmentedControlValueChanged:"), forControlEvents: .ValueChanged)
        navigationItem.titleView = navigationSegmentedControl
        
        // Created and designed in IB
        control1.titles = ["Recent","Nearby","All"]
        control1.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)!
        control1.alwaysAnnouncesValue = true
        print(control1.titles)
        
        // Control 2 is defined in IB
        
        // Many options & error handling
        control3.titles = ["One","Two","Three","Four","Five","Six"]
        control3.titleFont = UIFont(name: "HelveticaNeue-Light", size: 14.0)!
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
        
        // Added as a subview
        let viewSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 302.0, width: view.bounds.width, height: 50.0),
            titles: ["Artists", "Albums"],
            index: 1,
            backgroundColor: UIColor(red:0.11, green:0.12, blue:0.13, alpha:1.00),
            titleColor: .whiteColor(),
            indicatorViewBackgroundColor: UIColor(red:0.11, green:0.12, blue:0.13, alpha:1.00),
            selectedTitleColor: UIColor(red:0.97, green:0.00, blue:0.24, alpha:1.00))
        viewSegmentedControl.autoresizingMask = [.FlexibleWidth]
        viewSegmentedControl.cornerRadius = 0.0
        viewSegmentedControl.titleFont = UIFont(name: "HelveticaNeue", size: 16.0)!
        viewSegmentedControl.bouncesOnChange = false
        viewSegmentedControl.panningDisabled = true
        view.addSubview(viewSegmentedControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationSegmentedControlValueChanged(sender: BetterSegmentedControl) {

        let selectedMode = sender.titles[Int(sender.index)]
        
        if let lightMode = LightMode(rawValue: selectedMode) {
            if lightMode == .On {
                print("Turning lights on.")
                view.backgroundColor = .whiteColor()
            }
            else {
                print("Turning lights off.")
                view.backgroundColor = .darkGrayColor()
            }
        }
        
    }
    
    @IBAction func segmentedControl1ValueChanged(sender: BetterSegmentedControl) {
        print("The selected index is \(sender.index) and the title is \(sender.titles[Int(sender.index)])")
    }
    
}

