//
//  Displayable.swift
//
//  Created by António Nunes on 27/05/2023.
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

public protocol Displayable: Equatable, Identifiable, CustomStringConvertible, CustomDebugStringConvertible {
    var amount: Decimal { get }

    var locale: Locale { get set }
    var symbol: String { get }
    var separator: String { get }
    var name: String? { get }
    var nameForAmount: String? { get }

    func with(languageCode: String, regionCode: String) -> any Displayable

    var formatted: String? { get }
    func formatted(for: Locale, maximumFractionDigits: Int?) -> String?
    func formattedTruncatingDecimals(for locale: Locale) -> String?
    func formattedWithoutCurrencySymbol(for locale: Locale) -> String?
}

/// DisplayableMoney is a convenience available on Money, that provides easy access to textual representations of Money instances.
public struct DisplayableMoney<Curr: Currency>: Displayable {
    public let id = UUID()
    public let amount: Decimal

    public init(_ amount: Decimal) {
        self.amount = amount
        formatter.numberStyle = .currency
        formatter.currencyCode = Curr.code
    }

    public func with(languageCode: String, regionCode: String = "*") -> any Displayable {
        var copy = self
        copy.locale = Locale(identifier: "\(languageCode)_\(regionCode)")
        return copy
    }

    private var formatter = NumberFormatter()
    public var formatted: String? { formatter.string(for: amount) }

    public var locale: Locale {
        get { formatter.locale }
        set { formatter.locale = newValue }
    }

    public var symbol: String { formatter.currencySymbol }
    public var separator: String { formatter.currencyDecimalSeparator }
    public var name: String? { formatter.locale.localizedString(forCurrencyCode: formatter.currencyCode) }
    public var nameForAmount: String? {
        amount == 1 ? name : formatter.currencyName(for: amount)
    }
}

extension DisplayableMoney: Equatable {
    public static func == (lhs: DisplayableMoney, rhs: DisplayableMoney) -> Bool {
        lhs.formatted == rhs.formatted
    }
}

extension DisplayableMoney {
    public var description: String { formatted ?? "\(amount)" }
}

extension DisplayableMoney {
    public var debugDescription: String {
        """
        DisplayableMoney:
            Name: \(name ?? "")
            Currency Code: \(formatter.currencyCode ?? "")
            Currency Symbol: \(symbol)
            Currency Decimal Separator: \(separator)
            Currency Grouping Separator: \(formatter.currencyGroupingSeparator ?? "")
            Formatted: \(formatted ?? "\(amount)")
        """
    }
}

extension DisplayableMoney {
    public func formatted(for locale: Locale = .current, maximumFractionDigits: Int? = nil) -> String? {
        let savedLocale = formatter.locale
        if let maximumFractionDigits {
            formatter.maximumFractionDigits = maximumFractionDigits
        }
        defer {
            formatter.locale = savedLocale
        }

        formatter.locale = locale
        return formatter.string(for: amount)
    }

    /// Returns a string representing the amount, formatted according to the `nl_NL` locale, but replacing the decimals with "-"
    public func formattedTruncatingDecimals(for locale: Locale = .current) -> String? {
        let savedLocale = formatter.locale
        defer {
            formatter.locale = savedLocale
        }

        formatter.locale = locale
        return formatter.string(for: amount.currencyRounded(scale: 0, mode: .down))
    }

    /// Returns a string representing the amount, formatted according to the requested locale, but without the currency symbol.
    public func formattedWithoutCurrencySymbol(for locale: Locale = .current) -> String? {
        let savedLocale = formatter.locale
        let savedSymbol = formatter.currencySymbol
        defer {
            formatter.locale = savedLocale
            formatter.currencySymbol = savedSymbol
        }

        formatter.locale = locale
        formatter.currencySymbol = ""
        return formatter.string(for: amount)?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
