// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import BetterSegmentedControl

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("a BetterSegmentedControl") {
            context("when it is initialized") {

                it("can do maths") {
                    expect(23) == 23
                }

                it("can read") {
                    expect("🐮") == "🐮"
                }

                it("will eventually pass") {
                    var time = "passing"

                    dispatch_async(dispatch_get_main_queue()) {
                        time = "done"
                    }

                    waitUntil { done in
                        NSThread.sleepForTimeInterval(0.5)
                        expect(time) == "done"

                        done()
                    }
                }
            }
        }
    }
}
