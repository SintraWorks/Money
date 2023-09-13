//
//  CurencyRoundingTests.swift
//
//  Created by António Nunes on 28/05/2023.
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

import Foundation

import XCTest
@testable import Money

final class CurencyRoundingTests: XCTestCase {
    func testDecimalCurrencyRoundingScale() throws {
        var amount = Decimal(.pi)

        XCTAssertEqual(amount.currencyRounded(scale: 14), Decimal(string: "3.14159265358979"))

        amount.currencyRound(scale: 14)
        XCTAssertEqual(amount, Decimal(string: "3.14159265358979"))
        amount.currencyRound(scale: 3)
        XCTAssertEqual(amount, 3.142)
        amount.currencyRound(scale: 0)
        XCTAssertEqual(amount, 3)
        amount.currencyRound(scale: -1)
        XCTAssertEqual(amount, 0)

        var amount2 = Decimal(123)
        amount2.currencyRound(scale: -1)
        XCTAssertEqual(amount2, 120)
        amount2.currencyRound(scale: -2)
        XCTAssertEqual(amount2, 100)

        var amount3 = Decimal(30)
        var amount34 = Decimal(34)
        var amount36 = Decimal(36)
        amount3.currencyRound(scale: -1)
        XCTAssertEqual(amount3, 30)

        amount34.currencyRound(scale: -1)
        XCTAssertEqual(amount34, 30)
        amount36.currencyRound(scale: -1)
        XCTAssertEqual(amount36, 40)

        var amount35 = Decimal(35)
        amount35.currencyRound(scale: -1)
        XCTAssertEqual(amount35, 40)

        var amount25 = Decimal(25)
        amount25.currencyRound(scale: -1)
        XCTAssertEqual(amount25, 20)
    }

    func testecimalStringGetter() throws {
        var amount = Decimal(.pi)
        
        amount.currencyRound(scale: 14)
        XCTAssertEqual(amount.stringValue, Decimal(string: "3.14159265358979")!.stringValue)

        amount.currencyRound(scale: 4)
        XCTAssertEqual(amount.stringValue, Decimal(string: "3.1416")!.stringValue)

        amount.currencyRound(scale: 3)
        XCTAssertEqual(amount.stringValue, Decimal(string: "3.142")!.stringValue)

        amount.currencyRound(scale: 2)
        XCTAssertEqual(amount.stringValue, Decimal(string: "3.14")!.stringValue)
    }

    func testError() throws {
        let behaviour = CurrencyRoundingBehaviour(scale: Int16(0), roundingMode: .plain)
        let result = behaviour.exceptionDuringOperation(#selector(dummy), error: .noError, leftOperand: 0, rightOperand: 0)
        XCTAssertNil(result)
    }

    @objc func dummy() {}
}
