//
//  CurencyTests.swift
//
//  Created by António Nunes on 29/05/2023.
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

final class CurencyTests: XCTestCase {
    func testMinorUnitScale() throws {
        XCTAssertEqual(JPY.minorUnitScale, 0)
        XCTAssertEqual(EUR.minorUnitScale, 2)
        XCTAssertEqual(JOD.minorUnitScale, 3)
    }

    func testCode() throws {
        XCTAssertEqual(JPY.code, "JPY")
        XCTAssertEqual(EUR.code, "EUR")
        XCTAssertEqual(JOD.code, "JOD")
    }

    func testNameLocalized() throws {
        XCTAssertEqual(EUR.nameLocalized(for: "en"), "Euro")
        XCTAssertEqual(USD.nameLocalized(for: "en"), "US Dollar")
        XCTAssertEqual(JPY.nameLocalized(for: "en"), "Japanese Yen")

        XCTAssertEqual(EUR.nameLocalized(for: "ja"), "ユーロ")
        XCTAssertEqual(USD.nameLocalized(for: "ja"), "米ドル")
        XCTAssertEqual(JPY.nameLocalized(for: "ja"), "日本円")

        XCTAssertEqual(EUR.nameLocalized(for: "fr"), "euro")
        XCTAssertEqual(USD.nameLocalized(for: "fr"), "dollar des États-Unis")
        XCTAssertEqual(JPY.nameLocalized(for: "fr"), "yen japonais")
    }

    func testPluralizedNameLocalized() throws {
        XCTAssertEqual(EUR.pluralizedNameLocalized(languageCode: "en"), "euros")
        XCTAssertEqual(USD.pluralizedNameLocalized(languageCode: "en"), "US dollars")
        XCTAssertEqual(JPY.pluralizedNameLocalized(languageCode: "en"), "Japanese yen")

        XCTAssertEqual(EUR.pluralizedNameLocalized(languageCode: "nl"), "euro")
        XCTAssertEqual(USD.pluralizedNameLocalized(languageCode: "nl"), "Amerikaanse dollar")
        XCTAssertEqual(JPY.pluralizedNameLocalized(languageCode: "nl"), "Japanse yen")

        XCTAssertEqual(EUR.pluralizedNameLocalized(languageCode: "fr"), "euros")
        XCTAssertEqual(USD.pluralizedNameLocalized(languageCode: "fr"), "dollars des États-Unis")
        XCTAssertEqual(JPY.pluralizedNameLocalized(languageCode: "fr"), "yens japonais")

        XCTAssertEqual(EUR.pluralizedNameLocalized(languageCode: "zh"), "欧元")
        XCTAssertEqual(USD.pluralizedNameLocalized(languageCode: "zh"), "美元")
        XCTAssertEqual(JPY.pluralizedNameLocalized(languageCode: "zh"), "日元")

        XCTAssertEqual(EUR.pluralizedNameLocalized(languageCode: "ja"), "ユーロ")
        XCTAssertEqual(USD.pluralizedNameLocalized(languageCode: "ja"), "米ドル")
        XCTAssertEqual(JPY.pluralizedNameLocalized(languageCode: "ja"), "円")

        XCTAssertEqual(EUR.pluralizedNameLocalized(amount: 24, languageCode: "fr", regionCode: "JP"), "euros")
        XCTAssertEqual(USD.pluralizedNameLocalized(amount: 24, languageCode: "fr", regionCode: "JP"), "dollars des États-Unis")
        XCTAssertEqual(JPY.pluralizedNameLocalized(amount: 24, languageCode: "fr", regionCode: "JP"), "yens japonais")

    }

    // This test can be uncommented and run when there is a need to update the list of supported currencies.
    // Copy the resulting code from the console and paste it into the "Currencies.swift" file, overwriting the existing definitions.
    // The factory uses iOS's list of currencies to create the types. A hardcoded table is used for the minor unit scales, since iOS
    // doesn't provide data for those.
//    func testCreateCurrencies() throws {
//        print(MoneyFactory.createCurrencies())
//    }
}
