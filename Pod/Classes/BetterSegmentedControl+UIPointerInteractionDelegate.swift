//
//  BetterSegmentedControl+UIPointerInteractionDelegate.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 19.10.20.
//

#if canImport(UIKit)

import UIKit

@available(iOS 13.4, *)
extension BetterSegmentedControl: UIPointerInteractionDelegate {
    public func pointerInteraction(_ interaction: UIPointerInteraction,
                                   regionFor request: UIPointerRegionRequest,
                                   defaultRegion: UIPointerRegion) -> UIPointerRegion? {
        let closestIndexToRequestRegion = closestIndex(toPoint: request.location)
        
        let view = (closestIndexToRequestRegion == index) ? indicatorView : pointerInteractionViews[closestIndexToRequestRegion]
        pointerInteractionView = view
        
        return .init(rect: view.frame)
    }

    public func pointerInteraction(_ interaction: UIPointerInteraction,
                                   styleFor region: UIPointerRegion) -> UIPointerStyle? {
        guard let view = pointerInteractionView else {
            return nil
        }

        if view === indicatorView {
            return .init(effect: .lift(.init(view: view)))
        }
        return .init(effect: .highlight(.init(view: view)))
    }
}

#endif
