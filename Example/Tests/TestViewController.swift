//
//  TestViewController.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 23/04/16.
//  Copyright © 2016 George Marmaridis. All rights reserved.
//

import Foundation
import UIKit
import BetterSegmentedControl

class TestViewController: UIViewController {
    @IBOutlet weak var control: BetterSegmentedControl!
}

class TestViewController2: UIViewController {
    var valueChangedCalledCount = 0
    @objc func valueChanged() {
        valueChangedCalledCount += 1
    }
}
