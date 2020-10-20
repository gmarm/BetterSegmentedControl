//
//  BetterSegmentedControlTests.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 23/04/16.
//  Copyright © 2020 George Marmaridis. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import BetterSegmentedControl

final class BetterSegmentedControlSpec: QuickSpec {
    override func spec() {
        describe("a BetterSegmentedControl") {
            let testFrame = CGRect(x: 0, y: 0, width: 300, height: 44)
            let basicSegmentOne: [LabelSegment] = [.init(text: "One")]
            let basicSegmentsTwo: [LabelSegment] = [.init(text: "One"), .init(text: "Two")]
            let basicSegmentsThree: [LabelSegment] = [.init(text: "One"), .init(text: "Two"), .init(text: "Three")]
            let basicSegmentsFour: [LabelSegment] = [.init(text: "One"), .init(text: "Two"), .init(text: "Three"), .init(text: "Four")]
            
            var control: BetterSegmentedControl!
            
            // MARK: Basic init
            context("with most basic initialization") {
                context("with two segments") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsTwo)
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("has the expected property values") {
                        expect(control.alwaysAnnouncesValue).to(beFalse())
                        expect(control.announcesValueImmediately).to(beTrue())
                        expect(control.panningDisabled).to(beFalse())
                        expect(control.animationDuration).to(equal(0.3))
                        expect(control.animationSpringDamping).to(equal(0.75))
                    }
                }
                
                context("with three segments") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree)
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
                
                context("with four segments") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsFour)
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
            }
            
            // MARK: Storyboard init
            context("when initialized in a storyboard") {
                var viewController: StoryboardTestViewController!
                
                beforeEach({
                    let storyboard = UIStoryboard(name: "Test", bundle: Bundle(for: type(of: self)))
                    viewController = storyboard.instantiateInitialViewController() as? StoryboardTestViewController
                    UIApplication.shared.keyWindow!.rootViewController = viewController
                    _ = viewController.view
                    
                    control = viewController.control
                })
                
                context("when an expicit size is set in Auto Layout") {
                    beforeEach {
                        control = viewController.control
                    }
                    
                    it("renders correctly", closure: {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    })
                }
                
                context("when the control auto sizes itself in Auto Layout") {
                    beforeEach {
                        control = viewController.control2
                    }
                    
                    it("renders correctly", closure: {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    })
                }
            }
            
            // MARK: setIndex() / index
            describe("its index related methods and properties") {
                context("when index is not set during initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsFour)
                    }
                    
                    context("when setting the index to 1") {
                        beforeEach {
                            control.setIndex(1)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("returns the expected index property value") {
                            expect(control.index).to(equal(1))
                        }
                    }
                    
                    context("when setting the index to 2") {
                        beforeEach {
                            control.setIndex(2)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("returns the expected index property value") {
                            expect(control.index).to(equal(2))
                        }
                    }
                    
                    context("when setting the index to 3") {
                        beforeEach {
                            control.setIndex(3)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("returns the expected index property value") {
                            expect(control.index).to(equal(3))
                        }
                    }
                    
                    context("when setting the index to 3 and then 1") {
                        beforeEach {
                            control.setIndex(3)
                            control.setIndex(1)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("returns the expected index property value") {
                            expect(control.index).to(equal(1))
                        }
                    }
                    
                    context("when setting the index to minus 1") {
                        beforeEach {
                            control.setIndex(-1)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("returns the expected index property value") {
                            expect(control.index).to(equal(-1))
                        }
                    }
                    
                    context("when setting the index to minus 2") {
                        beforeEach {
                            control.setIndex(-2)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("returns the expected index property value") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("when setting the index to an index higher than the valid ones") {
                        beforeEach {
                            control.setIndex(10)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("returns the expected index property value") {
                            expect(control.index).to(equal(0))
                        }
                    }
                }
                
                context("when index is set during initialization") {
                    context("to 0") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsFour, index: 0)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("returns the expected index property value") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("to 1") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsFour, index: 1)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("returns the expected index property value") {
                            expect(control.index).to(equal(1))
                        }
                        
                        context("when setting the index to minus 1") {
                            beforeEach {
                                control.setIndex(-1)
                            }
                            
                            it("renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                            
                            it("returns the expected index property value") {
                                expect(control.index).to(equal(-1))
                            }
                        }
                        
                        context("when setting the index to minus 2") {
                            beforeEach {
                                control.setIndex(-2)
                            }
                            
                            it("renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                            
                            it("returns the expected index property value") {
                                expect(control.index).to(equal(1))
                            }
                        }
                        
                        context("when setting the index to an index higher than the valid ones") {
                            beforeEach {
                                control.setIndex(10)
                            }
                            
                            it("renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                            
                            it("returns the expected index property value") {
                                expect(control.index).to(equal(1))
                            }
                        }
                    }
                    
                    context("to minus 1") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsFour, index: -1)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("returns the expected index property value") {
                            expect(control.index).to(equal(-1))
                        }
                    }
                    
                    context("to minus 2") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsFour, index: -2)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("returns the expected index property value") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("to 10") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsFour, index: -2)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("returns the expected index property value") {
                            expect(control.index).to(equal(0))
                        }
                    }
                }
                
                // MARK: shouldSkipValueChangedEvent
                describe("its setIndex() shouldSkipValueChangedEvent parameter") {
                    var testViewController: TestViewController!
                    
                    beforeEach {
                        testViewController = TestViewController()
                        control = .init(frame: testFrame, segments: basicSegmentsThree)
                        control.addTarget(testViewController, action: #selector(TestViewController.valueChanged), for: .valueChanged)
                    }
                    
                    context("when false is passed to it") {
                        beforeEach {
                            control.setIndex(1, shouldSkipValueChangedEvent: false)
                            control.setIndex(2, shouldSkipValueChangedEvent: false)
                        }
                        
                        it("sends a valueChanged event") {
                            expect(testViewController.valueChangedCalledCount).to(equal(2))
                        }
                    }
                    
                    context("when false is passed to it") {
                        beforeEach {
                            control.setIndex(1, shouldSkipValueChangedEvent: true)
                            control.setIndex(2, shouldSkipValueChangedEvent: true)
                        }
                        
                        it("sends a valueChanged event") {
                            expect(testViewController.valueChangedCalledCount).to(equal(0))
                        }
                    }
                }
            }
            
            // MARK: alwaysAnnouncesValue
            describe("its alwaysAnnouncesValue property") {
                var testViewController: TestViewController!
                
                beforeEach {
                    testViewController = TestViewController()
                    control = .init(frame: testFrame, segments: basicSegmentsThree)
                    control.addTarget(testViewController, action: #selector(TestViewController.valueChanged), for: .valueChanged)
                }
                
                context("when it is false") {
                    beforeEach {
                        control.alwaysAnnouncesValue = false
                    }
                    
                    it("does send the expected events when setting the index") {
                        control.setIndex(0)
                        expect(testViewController.valueChangedCalledCount).to(equal(0))
                        
                        control.setIndex(1)
                        expect(testViewController.valueChangedCalledCount).to(equal(1))
                        
                        control.setIndex(0)
                        expect(testViewController.valueChangedCalledCount).to(equal(2))
                        
                        control.setIndex(0)
                        expect(testViewController.valueChangedCalledCount).to(equal(2))
                    }
                }
                
                context("when it is true") {
                    beforeEach {
                        control.alwaysAnnouncesValue = true
                    }
                    
                    it("does send the expected events when setting the index") {
                        control.setIndex(0)
                        expect(testViewController.valueChangedCalledCount).to(equal(1))
                        
                        control.setIndex(1)
                        expect(testViewController.valueChangedCalledCount).to(equal(2))
                        
                        control.setIndex(0)
                        expect(testViewController.valueChangedCalledCount).to(equal(3))
                        
                        control.setIndex(0)
                        expect(testViewController.valueChangedCalledCount).to(equal(4))
                    }
                }
            }
            
            // MARK: segments
            describe("its segments property") {
                context("when initialized with 0 segments") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: [])
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after setting segments to two") {
                        control.segments = basicSegmentsTwo
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
                
                context("when initialized with 1 segment") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentOne)
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after setting segments to two") {
                        control.segments = basicSegmentsTwo
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
                
                context("when initialized with 3 segments") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree)
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after setting segments to two") {
                        control.segments = basicSegmentsTwo
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after setting segments to two then four") {
                        control.segments = basicSegmentsTwo
                        control.segments = basicSegmentsFour
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
            }
            
            // MARK: cornerRadius
            describe("its cornerRadius property") {
                context("when it is set during initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree, options: [.cornerRadius(10.0)])
                        control.backgroundColor = .black
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after updating it to 0") {
                        control.cornerRadius = 0
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after updating it to 5") {
                        control.cornerRadius = 5
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
                
                context("when it is set after initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree)
                        control.backgroundColor = .black
                    }
                    
                    it("renders correctly after updating it to 0") {
                        control.cornerRadius = 0
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after updating it to 10") {
                        control.cornerRadius = 10
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
            }
            
            // MARK: indicatorViewBackgroundColor
            describe("its indicatorViewBackgroundColor property") {
                context("when it is set during initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree, options: [.indicatorViewBackgroundColor(.green)])
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after updating it") {
                        control.indicatorViewBackgroundColor = .blue
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
                
                context("when it is set after initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree)
                    }
                    
                    it("renders correctly after updating it") {
                        control.indicatorViewBackgroundColor = .green
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
            }
            
            // MARK: indicatorViewInset
            describe("its indicatorViewInset property") {
                context("when it is set during initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree, options: [.indicatorViewInset(2.0)])
                        control.backgroundColor = .black
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after updating it to 0") {
                        control.indicatorViewInset = 0
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after updating it to 4") {
                        control.indicatorViewInset = 4
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
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
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after updating it to 4") {
                        control.indicatorViewInset = 4
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
            }
            
            // added to prevent regression of https://github.com/gmarm/BetterSegmentedControl/issues/83
            context("when setting cornerRadius and indicatorViewInset") {
                context("first cornerRadius then indicatorViewInset") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree, options: [.cornerRadius(10.0),
                                                                                                  .indicatorViewInset(4.0)])
                        control.backgroundColor = .black
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
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
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
            }
            
            // MARK: indicatorViewBorderWidth / indicatorViewBorderColor
            describe("its indicator view border related properties") {
                context("when they are set during initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree, options: [.indicatorViewBorderWidth(2.0),
                                                                                                  .indicatorViewBorderColor(.green)])
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after updating border width to 0") {
                        control.indicatorViewBorderWidth = 0
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after updating border width to 4") {
                        control.indicatorViewBorderWidth = 4
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after updating border color to blue") {
                        control.indicatorViewBorderColor = .blue
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("renders correctly after updating border color to clear") {
                        control.indicatorViewBorderColor = .clear
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
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
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
            }
            
            // MARK: setOptions()
            describe("its setOptions() method") {
                beforeEach {
                    control = .init(frame: testFrame, segments: basicSegmentsThree)
                }
                
                context("when setting indicatorViewBackgroundColor") {
                    beforeEach {
                        control.setOptions([.indicatorViewBackgroundColor(.green)])
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
                
                context("when setting indicatorViewInset") {
                    beforeEach {
                        control.setOptions([.indicatorViewInset(8)])
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("has the expected value") {
                        expect(control.indicatorViewInset).to(equal(8))
                    }
                }
                
                context("when setting indicatorViewBorderWidth and indicatorViewBorderColor") {
                    beforeEach {
                        control.setOptions([.indicatorViewBorderWidth(4), .indicatorViewBorderColor(.green)])
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("has the expected values") {
                        expect(control.indicatorViewBorderWidth).to(equal(4))
                        expect(control.indicatorViewBorderColor).to(equal(.green))
                    }
                }
                
                context("when setting alwaysAnnouncesValue") {
                    context("to true") {
                        beforeEach {
                            control.setOptions([.alwaysAnnouncesValue(true)])
                        }
                        
                        it("returns the expected property value") {
                            expect(control.alwaysAnnouncesValue).to(beTrue())
                        }
                    }
                    context("to false") {
                        beforeEach {
                            control.setOptions([.alwaysAnnouncesValue(false)])
                        }
                        
                        it("returns the expected property value") {
                            expect(control.alwaysAnnouncesValue).to(beFalse())
                        }
                    }
                }
                
                context("when setting announcesValueImmediately") {
                    context("to true") {
                        beforeEach {
                            control.setOptions([.announcesValueImmediately(true)])
                        }
                        
                        it("returns the expected property value") {
                            expect(control.announcesValueImmediately).to(beTrue())
                        }
                    }
                    context("to false") {
                        beforeEach {
                            control.setOptions([.announcesValueImmediately(false)])
                        }
                        
                        it("returns the expected property value") {
                            expect(control.announcesValueImmediately).to(beFalse())
                        }
                    }
                }
                
                context("when setting panningDisabled") {
                    context("to true") {
                        beforeEach {
                            control.setOptions([.panningDisabled(true)])
                        }
                        
                        it("returns the expected property value") {
                            expect(control.panningDisabled).to(beTrue())
                        }
                    }
                    context("to false") {
                        beforeEach {
                            control.setOptions([.panningDisabled(false)])
                        }
                        
                        it("returns the expected property value") {
                            expect(control.panningDisabled).to(beFalse())
                        }
                    }
                }
                
                context("when setting animationDuration") {
                    beforeEach {
                        control.setOptions([.animationDuration(10.0)])
                    }
                    
                    it("returns the expected property value") {
                        expect(control.animationDuration).to(equal(10.0))
                    }
                }
                
                context("when setting animationSpringDamping") {
                    beforeEach {
                        control.setOptions([.animationSpringDamping(0.1)])
                    }
                    
                    it("returns the expected property value") {
                        expect(control.animationSpringDamping).to(equal(0.1))
                    }
                }
                
                context("when setting backgroundColor") {
                    beforeEach {
                        control.setOptions([.backgroundColor(.green)])
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                    
                    it("has the expected value") {
                        expect(control.backgroundColor).to(equal(.green))
                    }
                }
                
                context("when setting cornerRadius") {
                    beforeEach {
                        control.setOptions([.cornerRadius(10.0)])
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
            }
            
            // MARK: Indicator view shadow
            context("when adding a shadow to the indicator view") {
                beforeEach {
                    control = .init(frame: testFrame, segments: basicSegmentsThree)
                    control.indicatorView.layer.shadowColor = UIColor.black.cgColor
                    control.indicatorView.layer.shadowOpacity = 0.1
                    control.indicatorView.layer.shadowOffset = CGSize(width: 1, height: 1)
                    control.indicatorView.layer.shadowRadius = 2
                }
                
                it("renders correctly") {
                    //📷(control)
                    expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                }
            }
            
            // MARK: appleStyled() extension
            describe("its appleStyled extension") {
                beforeEach {
                    control = .appleStyled(frame: testFrame, titles: ["One", "Two", "Three"])
                }
                
                it("renders correctly") {
                    //📷(control)
                    expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                }
            }
        }
    }
}
