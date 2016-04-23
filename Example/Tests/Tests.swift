//
//  Tests.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 23/04/16.
//  Copyright © 2016 George Marmaridis. All rights reserved.
//

import Quick
import Nimble
@testable import BetterSegmentedControl

class BetterSegmentedControlSpec: QuickSpec {
    override func spec() {
        describe("a BetterSegmentedControl") {
            context("when it is initialized") {
                context("using the designated initializer") {
                    var control: BetterSegmentedControl!
                    beforeEach({
                        control = BetterSegmentedControl(
                            frame: CGRectMake(0, 0, 300, 44),
                            titles: ["One","Two"],
                            index: 1,
                            backgroundColor: .redColor(),
                            titleColor: .blueColor(),
                            indicatorViewBackgroundColor: .greenColor(),
                            selectedTitleColor: .purpleColor())
                    })
                    it("has the frame passed", closure: {
                        let frame = control.frame
                        expect(CGRectEqualToRect(frame,CGRectMake(0, 0, 300, 44))).to(beTrue())
                    })
                    it("has the index passed", closure: {
                        let index = control.index
                        expect(index) == 1
                    })
                    it("has the titles passed", closure: {
                        let titles = control.titles
                        expect(titles) == ["One","Two"]
                    })
                    it("has the background color passed", closure: {
                        let color = control.backgroundColor
                        expect(color).to(equal(UIColor.redColor()))
                    })
                    it("has the title color passed", closure: {
                        let color = control.titleColor
                        expect(color).to(equal(UIColor.blueColor()))
                    })
                    it("has the indicator view background color passed", closure: {
                        let color = control.indicatorViewBackgroundColor
                        expect(color).to(equal(UIColor.greenColor()))
                    })
                    it("has the selected title color passed", closure: {
                        let color = control.selectedTitleColor
                        expect(color).to(equal(UIColor.purpleColor()))
                    })
                }
                context("using initWithCoder") {
                    var control: BetterSegmentedControl!
                    beforeEach({
                        let storyboard = UIStoryboard(name: "Test",
                            bundle: NSBundle(forClass: self.dynamicType))
                        let viewController = storyboard.instantiateInitialViewController() as! TestViewController
                        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
                        expect(viewController).toNot(beNil())
                        expect(viewController.view).toNot(beNil())
                        expect(viewController.control).toNot(beNil())
                        control = viewController.control
                    })
                    it("is not nil", closure: {
                        expect(control).toNot(beNil())
                    })
                    it("has the frame set in IB", closure: {
                        let frame = control.frame
                        expect(CGRectEqualToRect(frame,CGRectMake(10, 30, 480, 40))).to(beTrue())
                    })
                    it("has the default index 0", closure: {
                        let index = control.index
                        expect(index) == 0
                    })
                    it("has the default titles 'First, Second'", closure: {
                        let titles = control.titles
                        expect(titles) == ["First","Second"]
                    })
                    it("has the background color set in IB", closure: {
                        let color = control.backgroundColor
                        expect(color).to(equal(UIColor(red: 0, green: 0, blue: 0, alpha: 1)))
                    })
                    it("has the title color set in IB", closure: {
                        let color = control.titleColor
                        expect(color).to(equal(UIColor(red: 1, green: 1, blue: 1, alpha: 1)))
                    })
                    it("has the indicator view background color set in IB", closure: {
                        let color = control.indicatorViewBackgroundColor
                        expect(color).to(equal(UIColor(red: 1, green: 1, blue: 1, alpha: 1)))
                    })
                    it("has the selected title color set in IB", closure: {
                        let color = control.selectedTitleColor
                        expect(color).to(equal(UIColor(red: 0, green: 0, blue: 0, alpha: 1)))
                    })
                }
            }
        }
    }
}
