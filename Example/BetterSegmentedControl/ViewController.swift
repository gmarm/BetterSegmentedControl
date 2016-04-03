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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Control as navigation item
        let navigationSegmentedControl = BetterSegmentedControl(titles: ["Lights On", "Lights Off"])
        navigationSegmentedControl.frame = CGRect(x: 35.0, y: 40.0, width: 200.0, height: 30.0)
        navigationSegmentedControl.cornerRadius = 3.0
        navigationSegmentedControl.titleFont = UIFont(name: "Avenir", size: 13.0)
        navigationSegmentedControl.backgroundColor = .darkGrayColor()
        navigationSegmentedControl.titleColor = .lightGrayColor()
        navigationSegmentedControl.selectedTitleColor = .whiteColor()
        navigationSegmentedControl.indicatorViewBackgroundColor = UIColor(red:0.55, green:0.26, blue:0.86, alpha:1.00)
        navigationSegmentedControl.bouncesOnChange = false
        navigationSegmentedControl.addTarget(self, action: #selector(ViewController.navigationSegmentedControlValueChanged(_:)), forControlEvents: .ValueChanged)
        navigationItem.titleView = navigationSegmentedControl
        
        // Created and designed in IB
        control1.titles = ["Recent","Nearby","All"]
        control1.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        control1.alwaysAnnouncesValue = true
        print(control1.titles)
        
        // Many options
        control3.titles = ["One","Two","Three","Four","Five","Six"]
        control3.titleFont = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        control3.index = 2
        
        // Added as a subview
        let viewSegmentedControl = BetterSegmentedControl(titles: ["Artists", "Albums"])
        viewSegmentedControl.frame = CGRect(x: 0.0, y: 302.0, width: view.bounds.width, height: 50.0)
        viewSegmentedControl.autoresizingMask = [.FlexibleWidth]
        viewSegmentedControl.cornerRadius = 0.0
        viewSegmentedControl.titleFont = UIFont(name: "HelveticaNeue", size: 16.0)
        viewSegmentedControl.backgroundColor = UIColor(red:0.11, green:0.12, blue:0.13, alpha:1.00)
        viewSegmentedControl.titleColor = .whiteColor()
        viewSegmentedControl.selectedTitleColor = UIColor(red:0.97, green:0.00, blue:0.24, alpha:1.00)
        viewSegmentedControl.indicatorViewBackgroundColor = UIColor(red:0.11, green:0.12, blue:0.13, alpha:1.00)
        viewSegmentedControl.bouncesOnChange = false
        viewSegmentedControl.index = 1
        viewSegmentedControl.panningDisabled = true
        view.addSubview(viewSegmentedControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
}

