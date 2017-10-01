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
                            options: [.backgroundColor(.red),
                                      .titleColor(.blue),
                                      .indicatorViewBackgroundColor(.green),
                                      .selectedTitleColor(.purple),
                                      .bouncesOnChange(false),
                                      .alwaysAnnouncesValue(true),
                                      .announcesValueImmediately(true),
                                      .panningDisabled(true),
                                      .cornerRadius(10.0),
                                      .indicatorViewInset(4.0),
                                      .indicatorViewBorderWidth(2.0),
                                      .indicatorViewBorderColor(.red),.titleFont(UIFont(name: "HelveticaNeue-Light", size: 14.0)!),
                                      .selectedTitleFont(UIFont(name: "HelveticaNeue-Light", size: 14.0)!),
                                      .titleBorderWidth(2.0),
                                      .titleBorderColor(UIColor.red)])
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
                    it("doesn't bounce on change", closure: {
                        expect(control.bouncesOnChange).to(beFalse())
                    })
                    it("can always announces its value on change", closure: {
                        expect(control.alwaysAnnouncesValue).to(beTrue())
                    })
                    it("announces value immediately", closure: {
                        expect(control.announcesValueImmediately).to(beTrue())
                    })
                    it("has panning disabled", closure: {
                        expect(control.panningDisabled).to(beTrue())
                    })
                    it("has the corner radius passed in init", closure: {
                        expect(control.cornerRadius).to(equal(10.0))
                    })
                    it("has the indicator view insets passed in init", closure: {
                        expect(control.indicatorViewInset).to(equal(4.0))
                    })
                    it("has the indicator view border width passed in init", closure: {
                        expect(control.indicatorViewBorderWidth).to(equal(2.0))
                    })
                    it("has the indicator view border color passed in init", closure: {
                        expect(control.indicatorViewBorderColor).to(equal(UIColor.red))
                    })
                    it("has the custom title font passed in init", closure: {
                        expect(control.titleFont).to(equal(UIFont(name: "HelveticaNeue-Light", size: 14.0)!))
                    })
                    it("has the custom selected title font passed in init", closure: {
                        expect(control.selectedTitleFont).to(equal(UIFont(name: "HelveticaNeue-Light", size: 14.0)!))
                    })
                    it("has the title border width passed in init", closure: {
                        expect(control.titleBorderWidth).to(equal(2.0))
                    })
                    
                    context("when a subview is added to its indicator") {
                        var underlineView: UIView!
                        beforeEach({
                            underlineView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
                            control.addSubviewToIndicator(underlineView)
                        })
                        it("has has a superview", closure: {
                            expect(underlineView.superview).toNot(beNil())
                        })
                    }
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
                        expect(control.titles) == ["First", "Second"]
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
                }
            }
        }
    }
}
