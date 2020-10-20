//
//  TestViewController.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 23/04/16.
//  Copyright © 2020 George Marmaridis. All rights reserved.
//

import Foundation
import UIKit
import BetterSegmentedControl

final class StoryboardTestViewController: UIViewController {
    @IBOutlet weak var explicitSizeControl: BetterSegmentedControl!
    @IBOutlet weak var selfSizingControl: BetterSegmentedControl!
}

final class TestViewController: UIViewController {
    var valueChangedCalledCount = 0
    @objc func valueChanged() {
        valueChangedCalledCount += 1
    }
}
