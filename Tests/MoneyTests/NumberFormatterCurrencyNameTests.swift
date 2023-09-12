//
//  NumberFormatterCurrencyNameTests.swift
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

final class NumberFormatterCurrencyNameTests: XCTestCase {
    func testCurrencyName() throws {
        let formatter = NumberFormatter()
        
        formatter.currencyCode = "USD"

        formatter.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter.currencyName(for: 0), "US Dollar")
        XCTAssertEqual(formatter.currencyName(for: 1), "US Dollar")
        XCTAssertEqual(formatter.currencyName(for: 2), "US dollars")

        formatter.locale = Locale(identifier: "fr_US")
        XCTAssertEqual(formatter.currencyName(for: 0), "dollar des États-Unis")
        XCTAssertEqual(formatter.currencyName(for: 1), "dollar des États-Unis")
        XCTAssertEqual(formatter.currencyName(for: 2), "dollars des États-Unis")

        formatter.locale = Locale(identifier: "en_FR")
        XCTAssertEqual(formatter.currencyName(for: 0), "US Dollar")
        XCTAssertEqual(formatter.currencyName(for: 1), "US Dollar")
        XCTAssertEqual(formatter.currencyName(for: 2), "US dollars")

        formatter.currencyCode = "EUR"

        formatter.locale = Locale(identifier: "en_FR")
        XCTAssertEqual(formatter.currencyName(for: 0), "Euro")
        XCTAssertEqual(formatter.currencyName(for: 1), "Euro")
        XCTAssertEqual(formatter.currencyName(for: 2), "euros")

        formatter.locale = Locale(identifier: "fr_FR")
        XCTAssertEqual(formatter.currencyName(for: 0), "euro")
        XCTAssertEqual(formatter.currencyName(for: 1), "euro")
        XCTAssertEqual(formatter.currencyName(for: 2), "euros")

        formatter.locale = Locale(identifier: "zh_CN")
        XCTAssertEqual(formatter.currencyName(for: 0), "欧元")
        XCTAssertEqual(formatter.currencyName(for: 1), "欧元")
        XCTAssertEqual(formatter.currencyName(for: 2), "欧元")

        formatter.locale = Locale(identifier: "nl_NL")
        XCTAssertEqual(formatter.currencyName(for: 0), "Euro")
        XCTAssertEqual(formatter.currencyName(for: 1), "Euro")
        XCTAssertEqual(formatter.currencyName(for: 2), "euro")
    }
}
