//
//  TenderTests.swift
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

import XCTest
@testable import Money

final class TenderInitializerTests: XCTestCase {
    func testTenderInitFromDecimal() throws {
        let amount: Decimal = 3.14

        let eur = Tender<EUR>(amount)
        XCTAssertTrue(eur.currency is EUR.Type)
        XCTAssertEqual(eur.amount, 3.14)

        let usd = Tender<USD>(amount)
        XCTAssertTrue(usd.currency is USD.Type)
        XCTAssertEqual(usd.amount, 3.14)
    }

    func testTenderInitFromInt() throws {
        let amount = 3

        let eur = Tender<EUR>(amount)
        XCTAssertTrue(eur.currency is EUR.Type)
        XCTAssertEqual(eur.amount, 3)
    }

    func testTenderInitFromDouble() throws {
        let amount = 3.14

        let eur = Tender<EUR>(amount)
        XCTAssertTrue(eur.currency is EUR.Type)
        XCTAssertEqual(eur.amount, 3.14)

        let usd = Tender<USD>(amount)
        XCTAssertTrue(usd.currency is USD.Type)
        XCTAssertEqual(usd.amount, 3.14)
    }

    func testTenderInitFromString() throws {
        let amount = "3.14"

        let eur = try unwrapAndAssertNotNil(Tender<EUR>(amount))
        XCTAssertTrue(eur.currency is EUR.Type)
        XCTAssertEqual(eur.amount, 3.14)

        let usd = try unwrapAndAssertNotNil(Tender<USD>(amount))
        XCTAssertNotNil(usd)
        XCTAssertTrue(usd.currency is USD.Type)
        XCTAssertEqual(usd.amount, 3.14)

        let invalid = Tender<EUR>("baloney sandwich")
        XCTAssertNil(invalid)

        let usdNL = try unwrapAndAssertNotNil(Tender<USD>("5,501", locale: Locale(identifier: "nl_NL")))
        XCTAssertNotNil(usdNL)
        XCTAssertTrue(usdNL.currency is USD.Type)
        XCTAssertEqual(usdNL.amount, 5.501)

        let invalid2 = Tender<USD>("baloney sandwich", locale: Locale(identifier: "nl_NL"))
        XCTAssertNil(invalid2)
    }

    func testTenderInitFromDecoder() throws {
        let json = #"{ "someMoney": 3.14 }"#
        let payload = json.data(using: .utf8)!

        struct Thing: Codable {
            var someMoney: Tender<EUR>
        }

        let thing = try JSONDecoder().decode(Thing.self, from: payload)
        XCTAssertTrue(thing.someMoney.currency is EUR.Type)
        XCTAssertEqual(thing.someMoney.amount, 3.14)

        let invalidJson = #"{ "someMoney": "this is not a decimal" }"#
        let invalidPayload = invalidJson.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode(Thing.self, from: invalidPayload))
    }

    func testTenderInitFromIntegerLiteral() throws {
        let eur: Tender<EUR> = 1
        XCTAssertTrue(eur.currency is EUR.Type)
        XCTAssertEqual(eur.amount, 1)
    }

    func testTenderInitFromFloatLiteral() throws {
        let eur: Tender<EUR> = 1.08
        XCTAssertEqual(eur.amount, 1.08)
    }

    func testTenderZero() throws {
        let zeroEur = Tender<EUR>.zero
        XCTAssertTrue(zeroEur.currency is EUR.Type)
        XCTAssertEqual(zeroEur.amount, 0)
    }

    func testMoneyFactory() throws {
        for currency in SupportedCurrency.allCases {
            let money = try MoneyFactory.moneyFrom(amount: 3.14, currency: currency)
            XCTAssertEqual(money.amount, 3.14)
            XCTAssertEqual(money.currency.code, currency.rawValue)
        }
    }
}

final class TenderEncoderTests: XCTestCase {
    func testTenderCoding() throws {
        let tender = Tender<EUR>(3.14)
        let data = try JSONEncoder().encode(tender)

        let thing = try JSONDecoder().decode(Tender<EUR>.self, from: data)
        XCTAssertEqual(tender, thing)
    }
}

final class TenderUnitsTests: XCTestCase {
    func testTenderUnits() throws {
        let tenderEUR = Tender<EUR>(3.14)
        XCTAssertEqual(tenderEUR.majorUnits, 3)
        XCTAssertEqual(tenderEUR.minorUnits, Decimal(string: "0.14"))

        let tenderJPY = Tender<JPY>(3.14)
        XCTAssertEqual(tenderJPY.majorUnits, 3)
        XCTAssertEqual(tenderJPY.minorUnits, Decimal(string: "0.14"))
    }

    func testTenderRounding() throws {
        let amount = Decimal(.pi)
        XCTAssertEqual(Tender<JPY>(amount).roundedAmount, 3)
        XCTAssertEqual(Tender<EUR>(amount).roundedAmount, Decimal(string: "3.14"))
        XCTAssertEqual(Tender<JOD>(amount).roundedAmount, Decimal(string: "3.142"))
    }
}

final class TenderSignTests: XCTestCase {
    func testTenderSign() throws {
        XCTAssertFalse(Tender<EUR>(0).isNegative)

        XCTAssertFalse(Tender<EUR>(floatLiteral: Double.leastNonzeroMagnitude).isNegative)
        XCTAssertFalse(Tender<EUR>(1).isNegative)
        XCTAssertFalse(Tender<EUR>(floatLiteral: Double.greatestFiniteMagnitude).isNegative)

        XCTAssertTrue(Tender<EUR>(floatLiteral: -Double.leastNonzeroMagnitude).isNegative)
        XCTAssertTrue(Tender<EUR>(-1).isNegative)
        XCTAssertTrue(Tender<EUR>(floatLiteral: -Double.greatestFiniteMagnitude).isNegative)
    }
}

final class TenderComparisonTests: XCTestCase {
    func testTenderEquality() throws {
        let amount = Decimal(.pi)
        let tenderEURPi = Tender<EUR>(amount)
        let tenderEURPiToo = Tender<EUR>(amount)
        let tenderEURPlus = Tender<EUR>(amount + 0.000001)
        let tenderEURMinus = Tender<EUR>(amount - 0.000001)

        XCTAssertEqual(tenderEURPi, tenderEURPiToo)
        XCTAssertNotEqual(tenderEURPi, tenderEURPlus)
        XCTAssertNotEqual(tenderEURPi, tenderEURMinus)
    }

    func testTenderComparison() throws {
        let amount = Decimal(.pi)
        let tenderEURPi = Tender<EUR>(amount)
        let tenderEURPlus = Tender<EUR>(amount + 0.000001)
        let tenderEURMinus = Tender<EUR>(amount - 0.000001)

        XCTAssertLessThan(tenderEURPi, tenderEURPlus)
        XCTAssertGreaterThan(tenderEURPi, tenderEURMinus)
    }
}
