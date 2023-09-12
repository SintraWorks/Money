//
//  TenderAlgebraTests.swift
//
//  Created by António Nunes on 30/05/2023.
//  Copyright © 2023 António Nunes, SintraWorks.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this source code and associated documentation files (the "SourceCode"), to deal
//  in the SourceCode without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute copies of the SourceCode, and to
//  sell software using the SourceCode, and permit persons to whom the SourceCode is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the SourceCode.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import XCTest
@testable import Money

enum MoneyTestError: Error {
//    case jsonToDataError
    case moneyFromStringInitializationError
}

final class TenderAlgebraTests: XCTestCase {
    func testTenderEquality() throws {
        let money1: Tender<EUR> = 1.5
        let money2: Tender<EUR> = 1.5
        // The next one is not representable in base 2, so we don't go through a double.
        guard let money3 = Tender<EUR>("1.501") else { throw MoneyTestError.moneyFromStringInitializationError }

        XCTAssertEqual(money1, money2)
        XCTAssertNotEqual(money1, money3)
    }

    func testTenderAddition() throws {
        guard
            let money1 = Tender<EUR>("1.5"),
            let money2 = Tender<EUR>("1.501")
        else { throw MoneyTestError.moneyFromStringInitializationError }

        XCTAssertEqual(money1 + money2, Tender<EUR>("3.001"))

        var money3 = money1
        money3 += money2
        XCTAssertEqual(money3, Tender<EUR>("3.001"))
    }

    func testTenderSubtraction() throws {
        guard
            let money1 = Tender<EUR>("1.5"),
            let money2 = Tender<EUR>("1.501")
        else { throw MoneyTestError.moneyFromStringInitializationError }

        XCTAssertEqual(money1 - money2, Tender<EUR>("-0.001"))

        var money3 = money1
        money3 -= money2
        XCTAssertEqual(money3, Tender<EUR>("-0.001"))
    }

    func testTenderMultiplication() throws {
        guard let money = Tender<EUR>("1.5") else { throw MoneyTestError.moneyFromStringInitializationError }

        XCTAssertEqual(money * 3, Tender<EUR>("4.5")) // Test multiplication by int
        XCTAssertEqual(money * -3.0, Tender<EUR>("-4.5")) // Test multiplication by double
        XCTAssertEqual(money * Decimal(-2), Tender<EUR>("-3")) // Test multiplication by double
        XCTAssertEqual(3 * money, Tender<EUR>("4.5")) // Test multiplication by int
        XCTAssertEqual(-3.0 * money, Tender<EUR>("-4.5")) // Test multiplication by double
        XCTAssertEqual(Decimal(2) * money, Tender<EUR>("3")) // Test multiplication by int

        var money1 = money
        money1 *= 3
        XCTAssertEqual(money1, Tender<EUR>("4.5"))

        var money2 = money
        money2 *= 3.0
        XCTAssertEqual(money2, Tender<EUR>("4.5"))

        var money3 = money
        money3 *= Decimal(3)
        XCTAssertEqual(money3, Tender<EUR>("4.5"))
    }

    func testTenderDivision() throws {
        guard let money = Tender<EUR>("1.5") else { throw MoneyTestError.moneyFromStringInitializationError }

        XCTAssertEqual(money / 3, Tender<EUR>("0.5")) // Test division by int
        XCTAssertEqual(money / -3.0, Tender<EUR>("-0.5")) // Test division by double
        XCTAssertEqual(money / Decimal(-2), Tender<EUR>("-0.75")) // Test multiplication by double
        XCTAssertEqual(3 / money, Tender<EUR>("2")) // Test multiplication by int
        XCTAssertEqual(-3.0 / money, Tender<EUR>("-2")) // Test multiplication by double
        XCTAssertEqual(Decimal(3) / money, Tender<EUR>(2)) // Test multiplication by int

        var money1 = money
        money1 /= 3
        XCTAssertEqual(money1, Tender<EUR>(0.5))

        var money2 = money
        money2 /= 3.0
        XCTAssertEqual(money2, Tender<EUR>(0.5))

        var money3 = money
        money3 /= Decimal(3)
        XCTAssertEqual(money3, Tender<EUR>(0.5))
    }

    func testNegation() throws {
        guard let money = Tender<EUR>("1.5") else { throw MoneyTestError.moneyFromStringInitializationError }

        XCTAssertEqual(-money, Tender<EUR>("-1.5"))
    }

}
