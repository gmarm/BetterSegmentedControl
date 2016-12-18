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
            context("after it is initialized") {
                context("using the designated initializer") {
                    var control: BetterSegmentedControl!
                    beforeEach({
                        control = BetterSegmentedControl(
                            frame: CGRect(x: 0, y: 0, width: 300, height: 44),
                            titles: ["One","Two"],
                            index: 1,
                            backgroundColor: .red,
                            titleColor: .blue,
                            indicatorViewBackgroundColor: .green,
                            selectedTitleColor: .purple)
                    })
                    it("has the frame passed", closure: {
                        expect(control.frame.equalTo(CGRect(x: 0, y: 0, width: 300, height: 44))).to(beTrue())
                    })
                    it("has the index passed", closure: {
                        expect(control.index) == 1
                    })
                    it("has the titles passed", closure: {
                        expect(control.titles) == ["One","Two"]
                    })
                    it("has the background color passed", closure: {
                        expect(control.backgroundColor).to(equal(UIColor.red))
                    })
                    it("has the title color passed", closure: {
                        expect(control.titleColor).to(equal(UIColor.blue))
                    })
                    it("has the indicator view background color passed", closure: {
                        expect(control.indicatorViewBackgroundColor).to(equal(UIColor.green))
                    })
                    it("has the selected title color passed", closure: {
                        expect(control.selectedTitleColor).to(equal(UIColor.purple))
                    })
                    describe("its bouncesOnChange property", closure: { 
                        it("defaults to true", closure: {
                            expect(control.bouncesOnChange).to(beTrue())
                        })
                        it("can be set", closure: {
                            control.bouncesOnChange = false
                            expect(control.bouncesOnChange).to(beFalse())
                        })
                    })
                    describe("its alwaysAnnouncesValue property", closure: {
                        it("defaults to false", closure: {
                            expect(control.alwaysAnnouncesValue).to(beFalse())
                        })
                        it("can be set", closure: {
                            control.alwaysAnnouncesValue = true
                            expect(control.alwaysAnnouncesValue).to(beTrue())
                        })
                    })
                    describe("its announcesValueImmediately property", closure: {
                        it("defaults to true", closure: {
                            expect(control.announcesValueImmediately).to(beTrue())
                        })
                        it("can be set", closure: {
                            control.announcesValueImmediately = false
                            expect(control.announcesValueImmediately).to(beFalse())
                        })
                    })
                    describe("its panningDisabled property", closure: {
                        it("defaults to false", closure: {
                            expect(control.panningDisabled).to(beFalse())
                        })
                        it("can be set", closure: {
                            control.panningDisabled = true
                            expect(control.panningDisabled).to(beTrue())
                        })
                    })
                    describe("its cornerRadius property", closure: {
                        it("defaults to 0", closure: {
                            expect(control.cornerRadius).to(equal(0.0))
                        })
                        it("can be set", closure: {
                            control.cornerRadius = 10.0
                            expect(control.cornerRadius).to(equal(10.0))
                        })
                    })
                    describe("its indicatorViewInset property", closure: {
                        it("defaults to 2.0", closure: {
                            expect(control.indicatorViewInset).to(equal(2.0))
                        })
                        it("can be set", closure: {
                            control.indicatorViewInset = 4.0
                            expect(control.indicatorViewInset).to(equal(4.0))
                        })
                    })
                    describe("its indicatorViewBorderWidth property", { 
                        it("defaults to 0.0", closure: {
                            expect(control.indicatorViewBorderWidth).to(equal(0.0))
                        })
                        it("can be set", closure: {
                            control.indicatorViewBorderWidth = 2.0
                            expect(control.indicatorViewBorderWidth).to(equal(2.0))
                        })
                    })
                    describe("its indicatorViewBorderColor property", {
                        it("can be set", closure: {
                            control.indicatorViewBorderColor = UIColor.red.cgColor
                            expect(control.indicatorViewBorderColor).to(equal(UIColor.red.cgColor))
                        })
                    })
                    describe("its titleFont property", closure: {
                        it("defaults to the default UILabel font", closure: {
                            expect(control.titleFont).to(equal(UILabel().font))
                        })
                        it("can be set", closure: {
                            let newFont = UIFont(name: "HelveticaNeue-Light", size: 14.0)!
                            control.titleFont = newFont
                            expect(control.titleFont).to(equal(newFont))
                        })
                    })
                    describe("its selectedTitleFont property", closure: {
                        it("defaults to the default UILabel font", closure: {
                            expect(control.selectedTitleFont).to(equal(UILabel().font))
                        })
                        it("can be set", closure: {
                            let newFont = UIFont(name: "HelveticaNeue-Light", size: 14.0)!
                            control.selectedTitleFont = newFont
                            expect(control.selectedTitleFont).to(equal(newFont))
                        })
                    })
                    describe("its titleBorderWidth property", {
                        it("defaults to 0.0", closure: {
                            expect(control.titleBorderWidth).to(equal(0.0))
                        })
                        it("can be set", closure: {
                            control.titleBorderWidth = 2.0
                            expect(control.titleBorderWidth).to(equal(2.0))
                        })
                    })
                    describe("its titleBorderColor property", {
                        it("can be set", closure: {
                            control.titleBorderColor = UIColor.red.cgColor
                            expect(control.titleBorderColor).to(equal(UIColor.red.cgColor))
                        })
                    })
                }
                context("using initWithCoder") {
                    var control: BetterSegmentedControl!
                    beforeEach({
                        let storyboard = UIStoryboard(name: "Test",
                            bundle: Bundle(for: type(of: self)))
                        let viewController = storyboard.instantiateInitialViewController() as! TestViewController
                        UIApplication.shared.keyWindow!.rootViewController = viewController
                        expect(viewController).toNot(beNil())
                        expect(viewController.view).toNot(beNil())
                        control = viewController.control
                    })
                    it("is not nil", closure: {
                        expect(control).toNot(beNil())
                    })
                    it("has the frame set in IB", closure: {
                        expect(control.frame.equalTo(CGRect(x: 10, y: 30, width: 480, height: 40))).to(beTrue())
                    })
                    it("has the default index 0", closure: {
                        expect(control.index) == 0
                    })
                    it("has the default titles 'First, Second'", closure: {
                        expect(control.titles) == ["First","Second"]
                    })
                    it("has the background color set in IB", closure: {
                        expect(control.backgroundColor).to(equal(UIColor(red: 0, green: 0, blue: 0, alpha: 1)))
                    })
                    it("has the title color set in IB", closure: {
                        expect(control.titleColor).to(equal(UIColor(red: 1, green: 1, blue: 1, alpha: 1)))
                    })
                    it("has the indicator view background color set in IB", closure: {
                        expect(control.indicatorViewBackgroundColor).to(equal(UIColor(red: 1, green: 1, blue: 1, alpha: 1)))
                    })
                    it("has the selected title color set in IB", closure: {
                        expect(control.selectedTitleColor).to(equal(UIColor(red: 0, green: 0, blue: 0, alpha: 1)))
                    })
                    describe("its bouncesOnChange property", closure: {
                        it("defaults to true", closure: {
                            expect(control.bouncesOnChange).to(beTrue())
                        })
                        it("can be set", closure: {
                            control.bouncesOnChange = false
                            expect(control.bouncesOnChange).to(beFalse())
                        })
                    })
                    describe("its alwaysAnnouncesValue property", closure: {
                        it("defaults to false", closure: {
                            expect(control.alwaysAnnouncesValue).to(beFalse())
                        })
                        it("can be set", closure: {
                            control.alwaysAnnouncesValue = true
                            expect(control.alwaysAnnouncesValue).to(beTrue())
                        })
                    })
                    describe("its announcesValueImmediately property", closure: {
                        it("defaults to true", closure: {
                            expect(control.announcesValueImmediately).to(beTrue())
                        })
                        it("can be set", closure: {
                            control.announcesValueImmediately = false
                            expect(control.announcesValueImmediately).to(beFalse())
                        })
                    })
                    describe("its panningDisabled property", closure: {
                        it("defaults to false", closure: {
                            expect(control.panningDisabled).to(beFalse())
                        })
                        it("can be set", closure: {
                            control.panningDisabled = true
                            expect(control.panningDisabled).to(beTrue())
                        })
                    })
                    describe("its cornerRadius property", closure: {
                        it("has the value set in IB", closure: {
                            expect(control.cornerRadius).to(equal(20.0))
                        })
                        it("can be set", closure: {
                            control.cornerRadius = 10.0
                            expect(control.cornerRadius).to(equal(10.0))
                        })
                    })
                    describe("its indicatorViewInset property", closure: {
                        it("defaults to 2.0", closure: {
                            expect(control.indicatorViewInset).to(equal(2.0))
                        })
                        it("can be set", closure: {
                            control.indicatorViewInset = 4.0
                            expect(control.indicatorViewInset).to(equal(4.0))
                        })
                    })
                    describe("its indicatorViewBorderWidth property", {
                        it("defaults to 0.0", closure: {
                            expect(control.indicatorViewBorderWidth).to(equal(0.0))
                        })
                        it("can be set", closure: {
                            control.indicatorViewBorderWidth = 2.0
                            expect(control.indicatorViewBorderWidth).to(equal(2.0))
                        })
                    })
                    describe("its indicatorViewBorderColor property", {
                        it("can be set", closure: {
                            control.indicatorViewBorderColor = UIColor.red.cgColor
                            expect(control.indicatorViewBorderColor).to(equal(UIColor.red.cgColor))
                        })
                    })
                    describe("its titleFont property", closure: {
                        it("defaults to the default UILabel font", closure: {
                            expect(control.titleFont).to(equal(UILabel().font))
                        })
                        it("can be set", closure: {
                            let newFont = UIFont(name: "HelveticaNeue-Light", size: 14.0)!
                            control.titleFont = newFont
                            expect(control.titleFont).to(equal(newFont))
                        })
                    })
                    describe("its selectedTitleFont property", closure: {
                        it("defaults to the default UILabel font", closure: {
                            expect(control.selectedTitleFont).to(equal(UILabel().font))
                        })
                        it("can be set", closure: {
                            let newFont = UIFont(name: "HelveticaNeue-Light", size: 14.0)!
                            control.selectedTitleFont = newFont
                            expect(control.selectedTitleFont).to(equal(newFont))
                        })
                    })
                    describe("its titleBorderWidth property", {
                        it("defaults to 0.0", closure: {
                            expect(control.titleBorderWidth).to(equal(0.0))
                        })
                        it("can be set", closure: {
                            control.titleBorderWidth = 2.0
                            expect(control.titleBorderWidth).to(equal(2.0))
                        })
                    })
                    describe("its titleBorderColor property", {
                        it("can be set", closure: {
                            control.titleBorderColor = UIColor.red.cgColor
                            expect(control.titleBorderColor).to(equal(UIColor.red.cgColor))
                        })
                    })
                }
            }
        }
    }
}
