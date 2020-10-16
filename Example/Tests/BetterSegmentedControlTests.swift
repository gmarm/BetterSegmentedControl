//
//  BetterSegmentedControlTests.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 23/04/16.
//  Copyright © 2016 George Marmaridis. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import BetterSegmentedControl

final class BetterSegmentedControlSnapshotSpec: QuickSpec {
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
            
            describe("its index setting method") {
                context("when index is not set during initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsFour)
                    }
                    
                    it("renders correctly after updating the index to 1") {
                        control.setIndex(1)
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating the index to 2") {
                        control.setIndex(2)
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating the index to 3") {
                        control.setIndex(3)
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating the index to 3 and then 1") {
                        control.setIndex(3)
                        control.setIndex(1)
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating the index to minus 1") {
                        control.setIndex(-1)
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating the index to minus 2") {
                        control.setIndex(-2)
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating the index to 10") {
                        control.setIndex(10)
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                }
                
                context("when index is set during initialization") {
                    context("to 0") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsFour, index: 0)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshot())
                        }
                    }
                    
                    context("to 1") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsFour, index: 1)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshot())
                        }
                    }
                    
                    context("to minus 1") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsFour, index: -1)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshot())
                        }
                    }
                    
                    context("to minus 2") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsFour, index: -2)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshot())
                        }
                    }
                    
                    context("to 10") {
                        beforeEach {
                            control = .init(frame: testFrame, segments: basicSegmentsFour, index: -2)
                        }
                        
                        it("renders correctly") {
                            //📷(control)
                            expect(control).to(haveValidSnapshot())
                        }
                    }
                }
            }
            
            describe("its cornerRadius property") {
                context("when it is set during initialization") {
                    beforeEach {
                        control = .init(frame: testFrame, segments: basicSegmentsThree, options: [.cornerRadius(10.0)])
                        control.backgroundColor = .black
                    }
                    
                    it("renders correctly") {
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating it to 0") {
                        control.cornerRadius = 0
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating it to 5") {
                        control.cornerRadius = 5
                        
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
                        control.cornerRadius = 0
                        
                        //📷(control)
                        expect(control).to(haveValidSnapshot())
                    }
                    
                    it("renders correctly after updating it to 10") {
                        control.cornerRadius = 10
                        
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
        }
    }
}
