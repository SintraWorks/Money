//
//  Tender.swift
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

/// A `Tender` represents a concrete monetary amount in a specific currency.
///
/// Because `Tender` conforms to `Money`, you can use `Tender` as either type, depending on the needs of the context within which it is used.
/// If you want to create monetary amounts at run time, say from a json payload, then you'll need to go through `Money`, or, if you want to have a collection of monetary amounts of different currencies,
/// you'll need to hold them in a collection of `Money`. You can cast them to `Tender` if and when needed.
/// If you don't need the flexibility that `Money` provides, then you're usually better off using `Tender`, and if you want to create monetary amounts directly, then you'll need to use `Tender`.
public struct Tender<C: Currency>: Money {
    public var amount: Decimal
    public var currency: Currency.Type { C.self }

    public init(_ amount: Decimal) {
        self.amount = amount
    }

    public init?(_ amountString: String) {
        guard let validAmount = Decimal(string: amountString) else { return nil }
        self.amount = validAmount
    }

    public var displayable: any Displayable {
        DisplayableMoney<C>(amount)
    }

    public var roundedAmount: Decimal {
        amount.currencyRounded(scale: C.minorUnitScale)
    }

    public var isNegative: Bool {
        amount < 0
    }

    public var majorUnits: Decimal { amount - minorUnits }
    public var minorUnits: Decimal { amount.mod(1) }

    public static func < (lhs: Tender<C>, rhs: Tender<C>) -> Bool {
        lhs.amount < rhs.amount
    }

    public static func == (lhs: Tender<C>, rhs: Tender<C>) -> Bool {
        lhs.amount == rhs.amount
    }
}

extension Tender {
    public init?(_ string: String, locale: Locale?) {
        guard let decimal = Decimal(string: string, locale: locale) else { return nil }
        self.init(decimal)
    }

    public init(_ value: Int) {
        self.init(Decimal(value))
    }

    public init(_ value: Double) {
        self.init(Decimal(value))
    }
}

// Conform to Codable
extension Tender {
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.amount = try container.decode(Decimal.self)
        } catch {
            throw error
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.amount)
    }
}

extension Tender: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(Decimal(value))
    }
}

extension Tender: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(Decimal(value))
    }
}

extension Tender: CustomStringConvertible {
    public var description: String {
        return displayable.formatted ?? "\(amount)"
    }
}

extension Tender: CustomDebugStringConvertible {
    public var debugDescription: String {
        return """
        Money:
            Currency: \(C.code) - \(C.nameLocalized(for: Locale.currentLanguageCode ?? "*") ?? "")
            Amount: \(amount)
            Displayable as: \(displayable)
        """
    }
}

extension Tender {
    /// Returns a Tender instance holding no money.
    public static var zero: Tender<C> { Tender<C>(0) }
}
