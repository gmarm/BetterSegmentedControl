//
//  SnapshotHelpers.swift
//  BetterSegmentedControl_Tests
//
//  Created by George Marmaridis on 18.10.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Nimble
import Nimble_Snapshots

public func haveValidSnapshotWithAcceptableTolerance() -> Predicate<Snapshotable> {
    haveValidSnapshot(named: nil, identifier: nil, usesDrawRect: false, tolerance: 0.01)
}
