//
//  DisplayableTests.swift
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

import Foundation

import XCTest
@testable import Money

final class DisplayableTests: XCTestCase {
    func testAmount() throws {
        let displayableEUR = DisplayableMoney<EUR>(3.14)
        XCTAssertEqual(displayableEUR.amount, 3.14)

        let displayableJPY = DisplayableMoney<JPY>(3)
        XCTAssertEqual(displayableJPY.amount, 3)
    }

    func testDescription() throws {
        let displayableEUR = DisplayableMoney<EUR>(3.14)
        XCTAssertEqual(displayableEUR.formatted, displayableEUR.description)
    }

    func testFormatted() throws {
        var displayableEUR = DisplayableMoney<EUR>(3.14)
        displayableEUR.locale = Locale(identifier: "en_US")
        XCTAssertEqual(displayableEUR.formatted, "€3.14")

        var displayableJPY = DisplayableMoney<JPY>(3)
        displayableJPY.locale = Locale(identifier: "en_US")
        XCTAssertEqual(displayableJPY.formatted, "¥3")

        var displayableUSD = DisplayableMoney<USD>(3.14)
        displayableUSD.locale = Locale(identifier: "en_US")
        XCTAssertEqual(displayableUSD.formatted, "$3.14")
    }

    func testLocale() throws {
        var displayableEUR = DisplayableMoney<EUR>(3.14)
        displayableEUR.locale = Locale(identifier: "nl_NL")
        XCTAssertEqual(displayableEUR.locale, Locale(identifier: "nl_NL"))
    }

    func testSymbol() throws {
        let displayableEUR = DisplayableMoney<EUR>(3.14)
        XCTAssertEqual(displayableEUR.symbol, "€")

        let displayableJPY = DisplayableMoney<JPY>(3)
        XCTAssertEqual(displayableJPY.symbol, "¥")

        let displayableUSD = DisplayableMoney<USD>(3.14)
        XCTAssertEqual(displayableUSD.symbol, "$")
    }

    func testSeparator() throws {
        let displayableEUR = DisplayableMoney<EUR>(3.14)
        XCTAssertEqual(displayableEUR.separator, ".")
    }

    func testName() throws {
        var displayableEUR = DisplayableMoney<EUR>(3.14)
        displayableEUR.locale = Locale(identifier: "en_US")
        XCTAssertEqual(displayableEUR.name, "Euro")

        var displayableJPY = DisplayableMoney<JPY>(3)
        displayableJPY.locale = Locale(identifier: "en_US")
        XCTAssertEqual(displayableJPY.name, "Japanese Yen")

        var displayableUSD = DisplayableMoney<USD>(3.14)
        displayableUSD.locale = Locale(identifier: "en_US")
        XCTAssertEqual(displayableUSD.name, "US Dollar")
    }

    func testNameforAmount() throws {
        var displayableEUR = DisplayableMoney<EUR>(3.14)
        displayableEUR.locale = Locale(identifier: "en_US")
        XCTAssertEqual(displayableEUR.nameForAmount, "euros")

        var displayableJPY = DisplayableMoney<JPY>(3)
        displayableJPY.locale = Locale(identifier: "en_US")
        XCTAssertEqual(displayableJPY.nameForAmount, "Japanese yen")

        var displayableUSD = DisplayableMoney<USD>(3.14)
        displayableUSD.locale = Locale(identifier: "en_US")
        XCTAssertEqual(displayableUSD.nameForAmount, "US dollars")
    }

    func testWithLanguageAndCountryCode() throws {
        let displayableEUR = DisplayableMoney<EUR>(3.14)
        XCTAssertEqual(displayableEUR.with(languageCode: "en", regionCode: "FR").name, "Euro")
        XCTAssertEqual(displayableEUR.with(languageCode: "nl", regionCode: "FR").name, "Euro")
        XCTAssertEqual(displayableEUR.with(languageCode: "fr", regionCode: "FR").name, "euro")
        XCTAssertEqual(displayableEUR.with(languageCode: "ja", regionCode: "FR").name, "ユーロ")

        XCTAssertEqual(displayableEUR.with(languageCode: "en", regionCode: "FR").formatted, "€3,14")
        XCTAssertEqual(displayableEUR.with(languageCode: "nl", regionCode: "FR").formatted, "€ 3,14")
        XCTAssertEqual(displayableEUR.with(languageCode: "fr", regionCode: "FR").formatted, "3,14 €")
        XCTAssertEqual(displayableEUR.with(languageCode: "ja", regionCode: "FR").formatted, "€3,14")

        XCTAssertEqual(displayableEUR.with(languageCode: "en", regionCode: "JP").formatted, "€3.14")
        XCTAssertEqual(displayableEUR.with(languageCode: "nl", regionCode: "JP").formatted, "€ 3.14")
        XCTAssertEqual(displayableEUR.with(languageCode: "fr", regionCode: "JP").formatted, "3.14 €")
        XCTAssertEqual(displayableEUR.with(languageCode: "ja", regionCode: "JP").formatted, "€3.14")

        let displayableJPY = DisplayableMoney<JPY>(3)
        XCTAssertEqual(displayableJPY.with(languageCode: "en", regionCode: "FR").name, "Japanese Yen")
        XCTAssertEqual(displayableJPY.with(languageCode: "nl", regionCode: "FR").name, "Japanse yen")
        XCTAssertEqual(displayableJPY.with(languageCode: "fr", regionCode: "FR").name, "yen japonais")
        XCTAssertEqual(displayableJPY.with(languageCode: "ja", regionCode: "FR").name, "日本円")

        XCTAssertEqual(displayableJPY.with(languageCode: "en", regionCode: "FR").formatted, "JP¥3")
        XCTAssertEqual(displayableJPY.with(languageCode: "nl", regionCode: "FR").formatted, "JP¥ 3")
        XCTAssertEqual(displayableJPY.with(languageCode: "fr", regionCode: "FR").formatted, "3 JPY")
        XCTAssertEqual(displayableJPY.with(languageCode: "ja", regionCode: "FR").formatted, "¥3")

        XCTAssertEqual(displayableJPY.with(languageCode: "en", regionCode: "JP").formatted, "¥3")
        XCTAssertEqual(displayableJPY.with(languageCode: "nl", regionCode: "JP").formatted, "¥ 3")
        XCTAssertEqual(displayableJPY.with(languageCode: "fr", regionCode: "JP").formatted, "3 ¥")
        XCTAssertEqual(displayableJPY.with(languageCode: "ja", regionCode: "JP").formatted, "¥3")
    }

    func testAmountFor() throws {
        let displayableEUR = DisplayableMoney<EUR>(1.234)
        XCTAssertEqual(displayableEUR.formatted(for: Locale(identifier: "nl_NL")), "€ 1,23")
        XCTAssertEqual(displayableEUR.formatted(for: Locale(identifier: "fr_FR")), "1,23 €")
        XCTAssertEqual(displayableEUR.formatted(for: Locale(identifier: "ja_JP")), "€1.23")

        let displayableJOD = DisplayableMoney<JOD>(1.234)
        XCTAssertEqual(displayableJOD.formatted(for: Locale(identifier: "nl_NL")), "JOD 1,234")
        XCTAssertEqual(displayableJOD.formatted(for: Locale(identifier: "fr_FR")), "1,234 JOD")
        XCTAssertEqual(displayableJOD.formatted(for: Locale(identifier: "ja_JP")), "JOD 1.234")
    }

    func testAmountWithoutDecimalsFor() throws {
        let displayableEUR = DisplayableMoney<EUR>(1000.234)
        XCTAssertEqual(displayableEUR.formattedTruncatingDecimals(for: Locale(identifier: "nl_NL")), "€ 1.000,00")
        XCTAssertEqual(displayableEUR.formattedTruncatingDecimals(for: Locale(identifier: "fr_CA")), "1 000,00 €")
        XCTAssertEqual(displayableEUR.formattedTruncatingDecimals(for: Locale(identifier: "en_US")), "€1,000.00")
    }

    func testAmountWithoutCurrencySymbolFor() throws {
        let displayableEUR = DisplayableMoney<EUR>(5432.234)
        XCTAssertEqual(displayableEUR.formattedWithoutCurrencySymbol(for: Locale(identifier: "nl_NL")), "5.432,23")
        XCTAssertEqual(displayableEUR.formattedWithoutCurrencySymbol(for: Locale(identifier: "fr_CA")), "5 432,23")
        XCTAssertEqual(displayableEUR.formattedWithoutCurrencySymbol(for: Locale(identifier: "en_US")), "5,432.23")
    }
}
