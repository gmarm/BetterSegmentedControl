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
            let testFrame = CGRect(x: 0, y: 0, width: 300, height: 44)
            let basicSegmentOne: [LabelSegment] = [.init(text: "One")]
            let basicSegmentsTwo: [LabelSegment] = [.init(text: "One"), .init(text: "Two")]
            let basicSegmentsThree: [LabelSegment] = [.init(text: "One"), .init(text: "Two"), .init(text: "Three")]
            let basicSegmentsFour: [LabelSegment] = [.init(text: "One"), .init(text: "Two"), .init(text: "Three"), .init(text: "Four")]
            
            var control: BetterSegmentedControl!
            
            context("with most basic initialization") {
                context("with two segments") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsTwo)
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                }
                
                context("with three segments") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree)
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                }
                
                context("with four segments") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsFour)
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                }
            }
            
            describe("its indicatorViewBackgroundColor property") {
                context("when it is set during initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree, options: [.indicatorViewBackgroundColor(.green)])
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating it") {
                        control.indicatorViewBackgroundColor = .blue
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                }
                
                context("when it is set after initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree)
                    }
                    
                    it("renders correctly after updating it") {
                        control.indicatorViewBackgroundColor = .green
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                }
            }
            
            describe("its indicatorViewInset property") {
                context("when it is set during initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree, options: [.indicatorViewInset(2.0)])
                        control.backgroundColor = .black
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating it to 0") {
                        control.indicatorViewInset = 0
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating it to 4") {
                        control.indicatorViewInset = 4
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                }
                
                context("when it is set after initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree)
                        control.backgroundColor = .black
                    }
                    
                    it("renders correctly after updating it to 0") {
                        control.indicatorViewInset = 0
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating it to 4") {
                        control.indicatorViewInset = 4
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                }
            }
            
            // added for https://github.com/gmarm/BetterSegmentedControl/issues/83
            context("when setting cornerRadius and indicatorViewInset") {
                context("first cornerRadius then indicatorViewInset") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree, options: [.cornerRadius(10.0),
                                                                                                  .indicatorViewInset(4.0)])
                        control.backgroundColor = .black
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                }
                
                context("first indicatorViewInset then cornerRadius") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree, options: [.indicatorViewInset(4.0),
                                                                                                  .cornerRadius(10.0)])
                        control.backgroundColor = .black
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                }
            }
            
            describe("its indicator view border related properties") {
                context("when they are set during initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree, options: [.indicatorViewBorderWidth(2.0),
                                                                                                  .indicatorViewBorderColor(.green)])
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating border width to 0") {
                        control.indicatorViewBorderWidth = 0

                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }

                    it("renders correctly after updating border width to 4") {
                        control.indicatorViewBorderWidth = 4

                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }

                    it("renders correctly after updating border color to blue") {
                        control.indicatorViewBorderColor = .blue

                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }

                    it("renders correctly after updating border color to clear") {
                        control.indicatorViewBorderColor = .clear

                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                }
                
                context("when they are set after initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree)
                    }
                    
                    it("renders correctly after updating border width to 2 and color to green") {
                        control.indicatorViewBorderWidth = 2
                        control.indicatorViewBorderColor = .green

                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                }
            }
            
            context("when initialized") {
                context("as example 1") {
                    var testViewController: TestViewController!
                    beforeEach({
                        testViewController = TestViewController()
                        
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
                        
                        control.addTarget(testViewController, action: #selector(TestViewController.valueChanged), for: .valueChanged)
                    })
                    it("renders correctly", closure: {
                        expect(control).to(haveValidSnapshot())
                    })
                    it("renders corner radius updates correctly", closure: {
                        control.setOptions([.cornerRadius(8)])
                        expect(control).to(haveValidSnapshot())
                    })
                    it("renders indicator view inset updates correctly", closure: {
                        control.setOptions([.indicatorViewInset(0)])
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
                context("as example 7") {
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
                context("as example 8") {
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
                context("as example 9") {
                    beforeEach({
                        let storyboard = UIStoryboard(name: "Test",
                                                      bundle: Bundle(for: type(of: self)))
                        let viewController = storyboard.instantiateInitialViewController() as! StoryboardTestViewController
                        UIApplication.shared.keyWindow!.rootViewController = viewController
                        expect(viewController).toNot(beNil())
                        expect(viewController.view).toNot(beNil())
                        control = viewController.control
                    })
                    it("renders correctly", closure: {
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    })
                }
            }
        }
    }
}
