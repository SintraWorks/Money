//
//  Currency.swift
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

/// A protocol that models the essentials of a currency type.
///
/// The `Currency` protocol exists to enable dynamic instantiation of Money types of particular currencies, and also to enable holding collections of amounts of money of varying currencies.
public protocol Currency {
    /// A code that identifies the currency, preferably along the ISO 4217 standard.
    static var code: String { get }
    /// The number of minor units the currency is divided into. The majority of currencies have a scale of 2.
    static var minorUnitScale: Int { get }

    /// The name of the currency.
    static func nameLocalized(for languageCode: String?) -> String?
    /// The plural form of the currency name for amounts greater than 1.
    static func pluralizedNameLocalized(amount: Decimal, languageCode: String?, regionCode: String) -> String?
}

extension Currency {
    public static var minorUnitScale: Int { 2 }

    public static var code: String { String(describing: self) }

    private static func currencyLocale(for languageCode: String, regionCode: String) -> Locale {
        Locale(identifier: "\(languageCode)_\(regionCode)@currency=\(Self.code)")
    }

    public static func nameLocalized(for languageCode: String? = nil) -> String? {
        currencyLocale(for: languageCode ?? Locale.current.languageCode ?? "en", regionCode: "*").localizedString(forCurrencyCode: Self.code)
    }

    public static func pluralizedNameLocalized(amount: Decimal = 2, languageCode: String? = nil, regionCode: String = "*") -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "\(languageCode ?? Locale.current.languageCode ?? "en")_\(regionCode)")
        formatter.currencyCode = code

        return formatter.currencyName(for: amount)
    }
}
