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
            
            // MARK: segments
            describe("its segments property") {
                context("when the control is initialized with zero segments") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: [])
                    }
                    
                    context("when setting segments to zero") {
                        beforeEach {
                            control.segments = []
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(-1))
                        }
                    }
                    
                    context("when setting segments to one") {
                        beforeEach {
                            control.segments = basicSegmentOne
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("when setting segments to two") {
                        beforeEach {
                            control.segments = basicSegmentsTwo
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("when setting segments to two and then three") {
                        beforeEach {
                            control.segments = basicSegmentsTwo
                            control.segments = basicSegmentsThree
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("when setting segments to three and then two") {
                        beforeEach {
                            control.segments = basicSegmentsThree
                            control.segments = basicSegmentsTwo
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(0))
                        }
                    }
                }
                
                context("when the control is initialized with one segment") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentOne)
                    }
                    
                    context("when setting segments to zero") {
                        beforeEach {
                            control.segments = []
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(-1))
                        }
                    }
                    
                    context("when setting segments to one") {
                        beforeEach {
                            control.segments = basicSegmentOne
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("when setting segments to two") {
                        beforeEach {
                            control.segments = basicSegmentsTwo
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("when setting segments to two and then three") {
                        beforeEach {
                            control.segments = basicSegmentsTwo
                            control.segments = basicSegmentsThree
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("when setting segments to three and then two") {
                        beforeEach {
                            control.segments = basicSegmentsThree
                            control.segments = basicSegmentsTwo
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(0))
                        }
                    }
                }
                
                context("when the control is initialized with two segments") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsTwo)
                    }
                    
                    context("when setting segments to zero") {
                        beforeEach {
                            control.segments = []
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(-1))
                        }
                    }
                    
                    context("when setting segments to one") {
                        beforeEach {
                            control.segments = basicSegmentOne
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("when setting segments to two") {
                        beforeEach {
                            control.segments = basicSegmentsTwo
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("when setting segments to two and then three") {
                        beforeEach {
                            control.segments = basicSegmentsTwo
                            control.segments = basicSegmentsThree
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("when setting segments to three and then two") {
                        beforeEach {
                            control.segments = basicSegmentsThree
                            control.segments = basicSegmentsTwo
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                        
                        it("has the expected index property") {
                            expect(control.index).to(equal(0))
                        }
                    }
                }
            }
            
            // MARK: cornerRadius
            describe("its cornerRadius property") {
                beforeEach {
                    control = .init(frame: testFrame, segments: basicSegmentsThree)
                    control.backgroundColor = .black
                }
                
                it("the control renders correctly when setting it to 0") {
                    control.cornerRadius = 0
                    
                    //📷(control)
                    expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                }
                
                it("the control renders correctly when setting it to 10") {
                    control.cornerRadius = 10
                    
                    //📷(control)
                    expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                }
            }
            
            // MARK: indicatorViewBackgroundColor
            describe("its indicatorViewBackgroundColor property") {
                beforeEach {
                    control = .init(frame: testFrame, segments: basicSegmentsThree)
                }
                
                it("the control renders correctly after updating it") {
                    control.indicatorViewBackgroundColor = .green
                    
                    //📷(control)
                    expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                }
            }
            
            // MARK: indicatorViewInset
            describe("its indicatorViewInset property") {
                beforeEach {
                    control = .init(frame: testFrame, segments: basicSegmentsThree)
                    control.backgroundColor = .black
                }
                
                it("the control renders correctly when setting it to 0") {
                    control.indicatorViewInset = 0
                    
                    //📷(control)
                    expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                }
                
                it("the control renders correctly when setting it to 4") {
                    control.indicatorViewInset = 4
                    
                    //📷(control)
                    expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                }
            }
            
            // MARK: indicatorViewBorderWidth
            describe("its indicatorViewBorderWidth property") {
                beforeEach {
                    control = .init(frame: testFrame, segments: basicSegmentsThree)
                }
                
                it("the control renders correctly when setting it to 4") {
                    control.indicatorViewBorderWidth = 4
                    
                    //📷(control)
                    expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                }
            }
            
            // MARK: indicatorViewBorderColor
            describe("its indicatorViewBorderColor property") {
                beforeEach {
                    control = .init(frame: testFrame, segments: basicSegmentsThree)
                    control.indicatorViewBorderWidth = 4
                }
                
                it("the control renders correctly when setting it to green") {
                    control.indicatorViewBorderColor = .green
                    
                    //📷(control)
                    expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                }
            }
            
            // MARK: segmentPadding
            describe("its segmentPadding property") {
                var viewController: StoryboardTestViewController!
                
                beforeEach({
                    let storyboard = UIStoryboard(name: "Test", bundle: Bundle(for: type(of: self)))
                    viewController = storyboard.instantiateInitialViewController() as? StoryboardTestViewController
                    UIApplication.shared.keyWindow!.rootViewController = viewController
                    _ = viewController.view
                    
                    control = viewController.selfSizingControl
                })
                
                context("when setting it to zero") {
                    beforeEach {
                        control.segmentPadding = 0
                    }
                    
                    it("the control renders correctly", closure: {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    })
                }
                
                context("when setting it to 8") {
                    beforeEach {
                        control.segmentPadding = 8
                    }
                    
                    it("the control renders correctly", closure: {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    })
                }
                
                context("when setting it to 28") {
                    beforeEach {
                        control.segmentPadding = 28
                    }
                    
                    it("the control renders correctly", closure: {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    })
                }
            }
            
            // MARK: init(frame:segments:index:options:)
            describe("its init(frame:segments:index:options:) initializer") {
                context("when calling it") {
                    context("in the most basic fashion") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsThree)
                        }
                        
                        it("the control has the expected default property values") {
                            expect(control.alwaysAnnouncesValue).to(beFalse())
                            expect(control.announcesValueImmediately).to(beTrue())
                            expect(control.panningDisabled).to(beFalse())
                            expect(control.animationDuration).to(equal(0.3))
                            expect(control.animationSpringDamping).to(equal(0.75))
                            expect(control.segmentPadding).to(equal(14.0))
                        }
                    }
                    
                    // segments
                    context("with 0 segments") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: [])
                        }
                        
                        it("the control renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                    }
                    
                    context("with 1 segment") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentOne)
                        }
                        
                        it("the control renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                    }
                    
                    context("with 2 segments") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsTwo)
                        }
                        
                        it("the control renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                    }
                    
                    context("with 3 segments") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsThree)
                        }
                        
                        it("the control renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                    }
                    
                    // index
                    context("with a valid index") {
                        context("that is minus 1") {
                            beforeEach {
                                control = .init(frame: testFrame, segments: basicSegmentsThree, index: -1)
                            }
                            
                            it("the control renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                            
                            it("the index property has the expected value") {
                                expect(control.index).to(equal(-1))
                            }
                        }
                        
                        context("that is 0") {
                            beforeEach {
                                control = .init(frame: testFrame, segments: basicSegmentsThree, index: 0)
                            }
                            
                            it("the control renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                            
                            it("the index property has the expected value") {
                                expect(control.index).to(equal(0))
                            }
                        }
                        
                        context("that is 1") {
                            beforeEach {
                                control = .init(frame: testFrame, segments: basicSegmentsThree, index: 1)
                            }
                            
                            it("the control renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                            
                            it("the index property has the expected value") {
                                expect(control.index).to(equal(1))
                            }
                        }
                        
                        context("that is 2") {
                            beforeEach {
                                control = .init(frame: testFrame, segments: basicSegmentsThree, index: 2)
                            }
                            
                            it("the control renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                            
                            it("the index property has the expected value") {
                                expect(control.index).to(equal(2))
                            }
                        }
                    }
                    
                    context("with an invalid index") {
                        context("that is minus 2") {
                            beforeEach {
                                control = .init(frame: testFrame, segments: basicSegmentsThree, index: -2)
                            }
                            
                            it("the control renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                            
                            it("the index property has the expected value") {
                                expect(control.index).to(equal(0))
                            }
                        }
                        
                        context("that is beyond the valid segment indices") {
                            beforeEach {
                                control = .init(frame: testFrame, segments: basicSegmentsThree, index: 10)
                            }
                            
                            it("the control renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                            
                            it("the index property has the expected value") {
                                expect(control.index).to(equal(0))
                            }
                        }
                    }
                    
                    context("with options") {
                        context("setting the indicatorViewBackgroundColor") {
                            beforeEach {
                                control = .init(frame: testFrame,
                                                segments: basicSegmentsThree,
                                                options: [.indicatorViewBackgroundColor(.green)])
                            }
                            
                            it("the control renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                        }
                        
                        context("setting the indicatorViewInset") {
                            beforeEach {
                                control = .init(frame: testFrame,
                                                segments: basicSegmentsThree,
                                                options: [.indicatorViewInset(8.0)])
                            }
                            
                            it("the control renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                        }
                        
                        context("setting the indicatorViewBorderWidth") {
                            beforeEach {
                                control = .init(frame: testFrame,
                                                segments: basicSegmentsThree,
                                                options: [.indicatorViewBorderWidth(4.0)])
                            }
                            
                            it("the control renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                        }
                        
                        context("setting the indicatorViewBorderColor") {
                            beforeEach {
                                control = .init(frame: testFrame,
                                                segments: basicSegmentsThree,
                                                options: [.indicatorViewBorderColor(.green)])
                                control.indicatorViewBorderWidth = 4.0
                            }
                            
                            it("the control renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                        }
                        
                        context("setting the alwaysAnnouncesValue property") {
                            context("to true") {
                                beforeEach {
                                    control = .init(frame: testFrame,
                                                    segments: basicSegmentsThree,
                                                    options: [.alwaysAnnouncesValue(true)])
                                }
                                
                                it("has the expected value") {
                                    expect(control.alwaysAnnouncesValue).to(beTrue())
                                }
                            }
                            
                            context("to false") {
                                beforeEach {
                                    control = .init(frame: testFrame,
                                                    segments: basicSegmentsThree,
                                                    options: [.alwaysAnnouncesValue(false)])
                                }
                                
                                it("has the expected value") {
                                    expect(control.alwaysAnnouncesValue).to(beFalse())
                                }
                            }
                        }
                        
                        context("setting the announcesValueImmediately property") {
                            context("to true") {
                                beforeEach {
                                    control = .init(frame: testFrame,
                                                    segments: basicSegmentsThree,
                                                    options: [.announcesValueImmediately(true)])
                                }
                                
                                it("has the expected value") {
                                    expect(control.announcesValueImmediately).to(beTrue())
                                }
                            }
                            
                            context("to false") {
                                beforeEach {
                                    control = .init(frame: testFrame,
                                                    segments: basicSegmentsThree,
                                                    options: [.announcesValueImmediately(false)])
                                }
                                
                                it("has the expected value") {
                                    expect(control.announcesValueImmediately).to(beFalse())
                                }
                            }
                        }
                        
                        context("setting the panningDisabled property") {
                            context("to true") {
                                beforeEach {
                                    control = .init(frame: testFrame,
                                                    segments: basicSegmentsThree,
                                                    options: [.panningDisabled(true)])
                                }
                                
                                it("has the expected value") {
                                    expect(control.panningDisabled).to(beTrue())
                                }
                            }
                            
                            context("to false") {
                                beforeEach {
                                    control = .init(frame: testFrame,
                                                    segments: basicSegmentsThree,
                                                    options: [.panningDisabled(false)])
                                }
                                
                                it("has the expected value") {
                                    expect(control.panningDisabled).to(beFalse())
                                }
                            }
                        }
                        
                        context("setting the animationDuration property") {
                            beforeEach {
                                control = .init(frame: testFrame,
                                                segments: basicSegmentsThree,
                                                options: [.animationDuration(10)])
                            }
                            
                            it("has the expected value") {
                                expect(control.animationDuration).to(equal(10))
                            }
                        }
                        
                        context("setting the animationSpringDamping property") {
                            beforeEach {
                                control = .init(frame: testFrame,
                                                segments: basicSegmentsThree,
                                                options: [.animationSpringDamping(0.1)])
                            }
                            
                            it("has the expected value") {
                                expect(control.animationSpringDamping).to(equal(0.1))
                            }
                        }
                        
                        context("setting the backgroundColor") {
                            beforeEach {
                                control = .init(frame: testFrame,
                                                segments: basicSegmentsThree,
                                                options: [.backgroundColor(.green)])
                            }
                            
                            it("the control renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                        }
                        
                        context("setting the cornerRadius") {
                            beforeEach {
                                control = .init(frame: testFrame,
                                                segments: basicSegmentsThree,
                                                options: [.cornerRadius(16.0)])
                            }
                            
                            it("the control renders correctly") {
                                //📷(control)
                                expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                            }
                        }
                    }
                }
            }
            
            // MARK: init(coder:)
            describe("its init(coder:) initializer") {
                context("when called") {
                    var viewController: StoryboardTestViewController!
                    
                    beforeEach({
                        let storyboard = UIStoryboard(name: "Test", bundle: Bundle(for: type(of: self)))
                        viewController = storyboard.instantiateInitialViewController() as? StoryboardTestViewController
                        UIApplication.shared.keyWindow!.rootViewController = viewController
                        _ = viewController.view
                        
                        control = viewController.explicitSizeControl
                    })
                    
                    context("when an expicit size is set in Auto Layout") {
                        beforeEach {
                            control = viewController.explicitSizeControl
                        }
                        
                        it("the control renders correctly", closure: {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        })
                    }
                    
                    context("when the control auto sizes itself in Auto Layout") {
                        beforeEach {
                            control = viewController.selfSizingControl
                        }
                        
                        it("the control renders correctly", closure: {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        })
                    }
                }
            }
            
            // MARK: init(frame:)
            describe("its init(frame:) initializer") {
                context("when called") {
                    beforeEach {
                        control = .init(frame: testFrame)
                    }
                    
                    it("the control renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                    }
                }
            }
            
            // MARK: init()
            describe("its init() initializer") {
                context("when called") {
                    beforeEach {
                        control = .init()
                    }
                    
                    it("the frame to be zero") {
                        expect(control.frame).to(equal(.zero))
                    }
                }
            }
            
            // MARK: setIndex()
            describe("its setIndex() method") {
                beforeEach {
                    control = .init(frame: testFrame, segments: basicSegmentsFour)
                }
                
                // index
                context("when called with an invalid index") {
                    context("that is too low") {
                        beforeEach {
                            control.setIndex(-2)
                        }
                        
                        it("does not update the control index") {
                            expect(control.index).to(equal(0))
                        }
                    }
                    
                    context("that is too high") {
                        beforeEach {
                            control.setIndex(10)
                        }
                        
                        it("does not update the control index") {
                            expect(control.index).to(equal(0))
                        }
                    }
                }
                
                context("when called with a valid index") {
                    context("that is minus 1") {
                        beforeEach {
                            control.setIndex(-1)
                        }
                        
                        it("the index property has the expected value") {
                            expect(control.index).to(equal(-1))
                        }
                        
                        it("the control renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                    }
                    
                    context("that is 0") {
                        beforeEach {
                            control.setIndex(0)
                        }
                        
                        it("the index property has the expected value") {
                            expect(control.index).to(equal(0))
                        }
                        
                        it("the control renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                    }
                    
                    context("that is 1") {
                        beforeEach {
                            control.setIndex(1)
                        }
                        
                        it("the index property has the expected value") {
                            expect(control.index).to(equal(1))
                        }
                        
                        it("the control renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                    }
                    
                    context("that is 2") {
                        beforeEach {
                            control.setIndex(2)
                        }
                        
                        it("the index property has the expected value") {
                            expect(control.index).to(equal(2))
                        }
                        
                        it("the control renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                    }
                    
                    context("that is 3") {
                        beforeEach {
                            control.setIndex(3)
                        }
                        
                        it("the index property has the expected value") {
                            expect(control.index).to(equal(3))
                        }
                        
                        it("the control renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshotWithAcceptableTolerance())
                        }
                    }
                }
                
                // alwaysAnnouncesValue
                context("when called with a alwaysAnnouncesValue parameter") {
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
                        
                        it("the control sends the expected events") {
                            control.setIndex(0, shouldSendValueChangedEvent: true)
                            expect(testViewController.valueChangedCalledCount).to(equal(0))
                            
                            control.setIndex(1, shouldSendValueChangedEvent: true)
                            expect(testViewController.valueChangedCalledCount).to(equal(1))
                            
                            control.setIndex(0, shouldSendValueChangedEvent: true)
                            expect(testViewController.valueChangedCalledCount).to(equal(2))
                            
                            control.setIndex(0, shouldSendValueChangedEvent: true)
                            expect(testViewController.valueChangedCalledCount).to(equal(2))
                        }
                    }
                    
                    context("when it is true") {
                        beforeEach {
                            control.alwaysAnnouncesValue = true
                        }
                        
                        it("the control sends the expected events") {
                            control.setIndex(0, shouldSendValueChangedEvent: true)
                            expect(testViewController.valueChangedCalledCount).to(equal(1))
                            
                            control.setIndex(1, shouldSendValueChangedEvent: true)
                            expect(testViewController.valueChangedCalledCount).to(equal(2))
                            
                            control.setIndex(0, shouldSendValueChangedEvent: true)
                            expect(testViewController.valueChangedCalledCount).to(equal(3))
                            
                            control.setIndex(0, shouldSendValueChangedEvent: true)
                            expect(testViewController.valueChangedCalledCount).to(equal(4))
                        }
                    }
                }
                
                // shouldSendValueChangedEvent
                context("when called with a shouldSendValueChangedEvent parameter") {
                    var testViewController: TestViewController!
                    
                    beforeEach {
                        testViewController = TestViewController()
                        control = .init(frame: testFrame, segments: basicSegmentsThree)
                        control.addTarget(testViewController, action: #selector(TestViewController.valueChanged), for: .valueChanged)
                    }
                    
                    context("when it is false") {
                        beforeEach {
                            control.setIndex(1, shouldSendValueChangedEvent: false)
                            control.setIndex(2, shouldSendValueChangedEvent: false)
                        }
                        
                        it("the control does not send a valueChanged event") {
                            expect(testViewController.valueChangedCalledCount).to(equal(0))
                        }
                    }
                    
                    context("when it is true") {
                        beforeEach {
                            control.setIndex(1, shouldSendValueChangedEvent: true)
                            control.setIndex(2, shouldSendValueChangedEvent: true)
                        }
                        
                        it("the control does send valueChanged events") {
                            expect(testViewController.valueChangedCalledCount).to(equal(2))
                        }
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
        }
    }
}
