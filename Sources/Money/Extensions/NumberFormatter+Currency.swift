//
//  NumberFormatter+Currency.swift
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

extension NumberFormatter {
    /// The appropriate name of the currency, according to the amount.
    ///
    /// Returns the pluralized name if the amount is greater than one.
    func currencyName(for amount: Decimal) -> String? {
        // NOTE: The localized names of currencies are derived from settings in locale, not from settings in the formatter.
        // For the singular form, this is obvious, because we request the localized string directly from the locale.
        // For the pluralized name, this is non-obvious, because we request the localized string from the formatter. However,
        // the formatter's locale's currency code doesn't necessarily reflect the formatter's currency code. So we need to ensure
        // correct locale currency code settings, for this to work.
        guard amount > 1 else {
            return locale.localizedString(forCurrencyCode: currencyCode)
        }

        let savedNumberStyle = numberStyle
        let savedLocale = locale
        defer {
            numberStyle = savedNumberStyle
            locale = savedLocale
        }

        numberStyle = .currencyPlural

        if #available(iOS 16, *) {
            var components = Locale.Components(languageCode: locale.language.languageCode, languageRegion: locale.region)
            components.currency = Locale.Currency(currencyCode)
            locale = Locale(components: components)
        } else if let languageCode = locale.languageCode, let regionCode = locale.regionCode, let currencyCode {
            locale = Locale(identifier: "\(languageCode)_\(regionCode)@currency=\(currencyCode)")
        }

        guard let amountAndCurrencyPlural = string(from: amount as NSNumber)
        else { return nil }

        // Remove the amount, since we are not interested in that.
        return amountAndCurrencyPlural.replacingOccurrences(of: #"\s*[\d+\.\,]\s*"#, with: "", options: .regularExpression)
    }
}
