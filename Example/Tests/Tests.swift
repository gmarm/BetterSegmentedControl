// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import BetterSegmentedControl

class BetterSegmentedControlSpec: QuickSpec {
    override func spec() {
        describe("a BetterSegmentedControl") {
            context("when it is initialized") {
                context("in code") {
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
                            expect(color) == .redColor()
                        })
                        it("has the title color passed", closure: {
                            let color = control.titleColor
                            expect(color) == UIColor.blueColor()
                        })
                        it("has the indicator view background color passed", closure: {
                            let color = control.indicatorViewBackgroundColor
                            expect(color) == .greenColor()
                        })
                        it("has the selected title color passed", closure: {
                            let color = control.selectedTitleColor
                            expect(color) == UIColor.purpleColor()
                        })
                    }
                }
            }
        }
    }
}
