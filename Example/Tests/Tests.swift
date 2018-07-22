//
//  Tests.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 23/04/16.
//  Copyright © 2016 George Marmaridis. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import BetterSegmentedControl

class BetterSegmentedControlSpec: QuickSpec {
    override func spec() {
        describe("a BetterSegmentedControl") {
            var control: BetterSegmentedControl!
            
            context("when initialized") {
                context("as example 1") {
                    var testViewController: TestViewController2!
                    beforeEach({
                        testViewController = TestViewController2()
                        
                        control = BetterSegmentedControl(
                            frame: CGRect(x: 0, y: 0, width: 300, height: 44),
                            segments: LabelSegment.segments(withTitles: ["One", "Two"],
                                                            normalBackgroundColor: .red,
                                                            normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                                                            normalTextColor: .lightGray,
                                                            selectedBackgroundColor: .blue,
                                                            selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
                                                            selectedTextColor: .white),
                            index: 1,
                            options: [.backgroundColor(.purple),
                                      .indicatorViewBackgroundColor(.green),
                                      .indicatorViewInset(4.0),
                                      .indicatorViewBorderWidth(2.0),
                                      .indicatorViewBorderColor(.magenta),
                                      .cornerRadius(15.0)])
                        
                        control.addTarget(testViewController, action: #selector(TestViewController2.valueChanged), for: .valueChanged)
                    })
                    it("renders correctly", closure: {
                        expect(control).to(haveValidSnapshot())
                    })
                    it("renders corner radius updates correctly", closure: {
                        control.options = [.cornerRadius(8)]
                        expect(control).to(haveValidSnapshot())
                    })
                    it("renders indicator view inset updates correctly", closure: {
                        control.options = [.indicatorViewInset(0)]
                        expect(control).to(haveValidSnapshot())
                    })
                    it("behaves correctly when setting index", closure: {
                        control.setIndex(0)
                        control.setIndex(1)
                        expect(testViewController.valueChangedCalledCount).to(equal(2))
                    })
                }
                context("as example 2") {
                    beforeEach({
                        control = BetterSegmentedControl(
                            frame: CGRect(x: 0, y: 0, width: 300, height: 44),
                            segments: LabelSegment.segments(withTitles: ["One", "Two"],
                                                            normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                                                            normalTextColor: .lightGray,
                                                            selectedBackgroundColor: .blue,
                                                            selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
                                                            selectedTextColor: .white),
                            index: 1,
                            options: [.backgroundColor(.purple),
                                      .indicatorViewBackgroundColor(.green),
                                      .indicatorViewInset(4.0),
                                      .indicatorViewBorderWidth(2.0),
                                      .indicatorViewBorderColor(.magenta),
                                      .cornerRadius(15.0)])
                    })
                    it("renders correctly", closure: {
                        expect(control).to(haveValidSnapshot())
                    })
                }
                context("as example 3") {
                    beforeEach({
                        control = BetterSegmentedControl(
                            frame: CGRect(x: 0, y: 0, width: 300, height: 44),
                            segments: LabelSegment.segments(withTitles: ["One", "Two"],
                                                            normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                                                            normalTextColor: .lightGray,
                                                            selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
                                                            selectedTextColor: .white),
                            index: 1,
                            options: [.backgroundColor(.purple),
                                      .indicatorViewBackgroundColor(.green),
                                      .indicatorViewInset(4.0),
                                      .indicatorViewBorderWidth(2.0),
                                      .indicatorViewBorderColor(.magenta),
                                      .cornerRadius(15.0)])
                    })
                    it("renders correctly", closure: {
                        expect(control).to(haveValidSnapshot())
                    })
                }
                context("as example 4") {
                    beforeEach({
                        control = BetterSegmentedControl(
                            frame: CGRect(x: 0, y: 0, width: 300, height: 44),
                            segments: LabelSegment.segments(withTitles: ["One", "Two"],
                                                            normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                                                            normalTextColor: .lightGray,
                                                            selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
                                                            selectedTextColor: .white),
                            index: 1,
                            options: [.backgroundColor(.purple),
                                      .indicatorViewBackgroundColor(.green),
                                      .indicatorViewBorderWidth(2.0),
                                      .indicatorViewBorderColor(.magenta),
                                      .cornerRadius(15.0)])
                    })
                    it("renders correctly", closure: {
                        expect(control).to(haveValidSnapshot())
                    })
                }
                context("as example 5") {
                    beforeEach({
                        control = BetterSegmentedControl(
                            frame: CGRect(x: 0, y: 0, width: 300, height: 44),
                            segments: LabelSegment.segments(withTitles: ["One", "Two"],
                                                            normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                                                            normalTextColor: .lightGray,
                                                            selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
                                                            selectedTextColor: .white),
                            index: 1,
                            options: [.backgroundColor(.purple),
                                      .indicatorViewBackgroundColor(.green),
                                      .indicatorViewBorderWidth(2.0),
                                      .cornerRadius(15.0)])
                    })
                    it("renders correctly", closure: {
                        expect(control).to(haveValidSnapshot())
                    })
                }
                context("as example 6") {
                    beforeEach({
                        control = BetterSegmentedControl(
                            frame: CGRect(x: 0, y: 0, width: 300, height: 44),
                            segments: LabelSegment.segments(withTitles: ["One", "Two"],
                                                            normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                                                            normalTextColor: .lightGray,
                                                            selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
                                                            selectedTextColor: .white),
                            index: 1,
                            options: [.backgroundColor(.purple),
                                      .indicatorViewBackgroundColor(.green),
                                      .cornerRadius(15.0)])
                    })
                    it("renders correctly", closure: {
                        expect(control).to(haveValidSnapshot())
                    })
                }
                context("as example 6") {
                    beforeEach({
                        control = BetterSegmentedControl(
                            frame: CGRect(x: 0, y: 0, width: 300, height: 44),
                            segments: LabelSegment.segments(withTitles: ["One", "Two"],
                                                            normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
                                                            normalTextColor: .lightGray,
                                                            selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
                                                            selectedTextColor: .white),
                            index: 1,
                            options: [.backgroundColor(.purple),
                                      .indicatorViewBackgroundColor(.red)])
                    })
                    it("renders correctly", closure: {
                        expect(control).to(haveValidSnapshot())
                    })
                }
                context("as example 7") {
                    beforeEach({
                        control = BetterSegmentedControl(
                            frame: CGRect(x: 0.0, y: 400.0, width: 300, height: 30.0),
                            segments: IconSegment.segments(withIcons: [#imageLiteral(resourceName: "facebook"), #imageLiteral(resourceName: "twitter")],
                                                           iconSize: CGSize(width: 20.0, height: 20.0),
                                                           normalIconTintColor: .white,
                                                           selectedIconTintColor: UIColor(red:0.16, green:0.64, blue:0.94, alpha:1.00)),
                            options: [.cornerRadius(15.0),
                                      .backgroundColor(UIColor(red:0.16, green:0.64, blue:0.94, alpha:1.00)),
                                      .indicatorViewBackgroundColor(.white)])
                    })
                    it("renders correctly", closure: {
                        expect(control).to(haveValidSnapshot())
                    })
                }
                context("as example 8") {
                    beforeEach({
                        let storyboard = UIStoryboard(name: "Test",
                                                      bundle: Bundle(for: type(of: self)))
                        let viewController = storyboard.instantiateInitialViewController() as! TestViewController
                        UIApplication.shared.keyWindow!.rootViewController = viewController
                        expect(viewController).toNot(beNil())
                        expect(viewController.view).toNot(beNil())
                        control = viewController.control
                    })
                    it("renders correctly", closure: {
                        expect(control).to(haveValidSnapshot())
                    })
                }
            }
        }
    }
}
