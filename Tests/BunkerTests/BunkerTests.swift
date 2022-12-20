//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import XCTest
@testable import Bunker

final class BunkerTests: XCTestCase {
    func testClamping() throws {
        let clampedValue = 42.clamp(lower: 1, upper: 9000)
        XCTAssertEqual(clampedValue, 42)

        let outOfBounds = 42.clamp(lower: 1, upper: 10)
        XCTAssertEqual(outOfBounds, 10)

        let outOfLowerBounds = 42.clamp(lower: 50, upper: 100)
        XCTAssertEqual(outOfLowerBounds, 50)
    }

    func testClampingWrapper() throws {
        @Clamped(upperBound: 10) var zeroToTen = 1
        XCTAssertTrue((0..<11).contains(zeroToTen))

        zeroToTen = 20
        XCTAssertEqual(zeroToTen, 10)

        zeroToTen = -69
        XCTAssertEqual(zeroToTen, 0)
    }
}
