//
//  Decimal+Rounding.swift
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

class CurrencyRoundingBehaviour: NSDecimalNumberBehaviors {
    internal init(scale: Int16, roundingMode: NSDecimalNumber.RoundingMode) {
        self._scale = scale
        self._roundingMode = roundingMode
    }

    private var _scale: Int16
    private var _roundingMode: NSDecimalNumber.RoundingMode

    func roundingMode() -> NSDecimalNumber.RoundingMode {
        .bankers
    }

    func scale() -> Int16 {
        _scale
    }

    func exceptionDuringOperation(_ operation: Selector, error: NSDecimalNumber.CalculationError, leftOperand: NSDecimalNumber, rightOperand: NSDecimalNumber?) -> NSDecimalNumber? {
        nil
    }
}

extension Decimal {
    public mutating func currencyRound(scale: Int = 2, mode roundingMode: NSDecimalNumber.RoundingMode = .bankers) {
        self = (self as NSDecimalNumber).rounding(accordingToBehavior: CurrencyRoundingBehaviour(scale: Int16(scale), roundingMode: roundingMode)) as Decimal
    }

    public func currencyRounded(scale: Int = 2, mode roundingMode: NSDecimalNumber.RoundingMode = .bankers) -> Decimal {
        (self as NSDecimalNumber).rounding(accordingToBehavior: CurrencyRoundingBehaviour(scale: Int16(scale), roundingMode: roundingMode)) as Decimal
    }

    public var stringValue: String {
        NSDecimalNumber(decimal: self).description(withLocale: Locale.current)
    }
}

extension Decimal {
    public func mod(_ other: Decimal) -> Decimal {
        var div = self / other
        var dec: Decimal = 0
        NSDecimalRound(&dec, &div, 0, .down)
        return self - (other * dec)
    }
}
