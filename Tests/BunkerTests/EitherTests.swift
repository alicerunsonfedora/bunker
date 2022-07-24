//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import XCTest
@testable import Bunker

final class EitherTests: XCTestCase {
    func testGetEitherSucceeds() throws {
        let leftEither: Either<Int?, Int> = .left(42)
        let rightEither: Either<Int?, Int> = .right(13)

        let leftResult = leftEither.getEither { left in
            "\(left ?? 0)"
        } defaultCase: { right in
            "\(right)"
        }

        let rightResult = rightEither.getEither { left in
            "\(left ?? 0)"
        } defaultCase: { right in
            "\(right)"
        }

        XCTAssertEqual("42", leftResult)
        XCTAssertEqual("13", rightResult)
    }

    func testEitherIsEquatable() throws {
        let first = Either<Int?, Int>.left(nil)
        let second = Either<Int?, Int>.left(nil)
        XCTAssertEqual(first, second)

        let third = Either<Int?, Int>.right(0)
        let fourth = Either<Int?, Int>.left(0)
        XCTAssertNotEqual(third, fourth)
    }

    func testDoEitherSucceeds() throws {
        var exampleStr = "Hello, world!"
        let eitherCase = Either<Int?, Int>.left(42)

        eitherCase.doFailable { left in
            exampleStr += " ID: \(left ?? -1)"
        }

        XCTAssertEqual("Hello, world! ID: 42", exampleStr)

        let otherEither = Either<Int?, Int>.right(46)
        otherEither.doDefault { right in
            exampleStr = "Hello, world! ID: \(right)"
        }
        XCTAssertEqual("Hello, world! ID: 46", exampleStr)
    }

    func testMapFailableOnEither() throws {
        let exampleStr = "42,5,78,12,23"
        let either = Either<String?, String>.left(exampleStr)
            .mapFailable { str in
                str?.split(separator: ",") ?? []
            }
            .mapFailable { list in
                list.map { element in
                    Int(element)
                }
            }
        XCTAssertTrue(type(of: either) == Either<[Int?], String>.self)
        XCTAssertEqual(Either<[Int?], String>.left([42, 5, 78, 12, 23]), either)
    }
}
