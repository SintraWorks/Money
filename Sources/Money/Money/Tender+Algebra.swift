//
//  Tender+Algebra.swift
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

// Algebraic

// Addition & Substraction: We can add and subtract Tender instances to and from each other.
extension Tender {
    public static func + (lhs: Tender, rhs: Tender) -> Tender {
        Tender(lhs.amount + rhs.amount)
    }

    public static func += (lhs: inout Tender, rhs: Tender) {
        lhs.amount += rhs.amount
    }

    public static func - (lhs: Tender, rhs: Tender) -> Tender {
        Tender(lhs.amount - rhs.amount)
    }

    public static func -= (lhs: inout Tender, rhs: Tender) {
        lhs.amount -= rhs.amount
    }
}

// Multiplication: We cannot multiply Tender instances by each other, but it makes sense to be able to multiply by some numeric types.
extension Tender {
    // Decimal
    public static func * (lhs: Tender, rhs: Decimal) -> Tender {
        Tender(lhs.amount * rhs)
    }

    public static func * (lhs: Decimal, rhs: Tender) -> Tender {
        Tender(lhs * rhs.amount)
    }

    public static func *= (lhs: inout Tender, rhs: Decimal) {
        lhs.amount *= rhs
    }

    // Int
    public static func * (lhs: Tender, rhs: Int) -> Tender {
        Tender(lhs.amount * Decimal(rhs))
    }

    public static func * (lhs: Int, rhs: Tender) -> Tender {
        Tender(Decimal(lhs) * rhs.amount)
    }

    public static func *= (lhs: inout Tender, rhs: Int) {
        lhs.amount *= Decimal(rhs)
    }

    // Double
    public static func * (lhs: Tender, rhs: Double) -> Tender {
        Tender(lhs.amount * Decimal(rhs))
    }

    public static func * (lhs: Double, rhs: Tender) -> Tender {
        Tender(Decimal(lhs) * rhs.amount)
    }

    public static func *= (lhs: inout Tender, rhs: Double) {
        lhs.amount *= Decimal(rhs)
    }
}

// Division: We cannot divide Tender instances by each other, but it makes sense to be able to divide by some numeric types.
extension Tender {
    // Decimal
    public static func / (lhs: Tender, rhs: Decimal) -> Tender {
        Tender(lhs.amount / rhs)
    }

    public static func / (lhs: Decimal, rhs: Tender) -> Tender {
        Tender(lhs / rhs.amount)
    }

    public static func /= (lhs: inout Tender, rhs: Decimal) {
        lhs.amount /= rhs
    }

    // Int
    public static func / (lhs: Tender, rhs: Int) -> Tender {
        Tender(lhs.amount / Decimal(rhs))
    }

    public static func / (lhs: Int, rhs: Tender) -> Tender {
        Tender(Decimal(lhs) / rhs.amount)
    }

    public static func /= (lhs: inout Tender, rhs: Int) {
        lhs.amount /= Decimal(rhs)
    }

    // Double
    public static func / (lhs: Tender, rhs: Double) -> Tender {
        Tender(lhs.amount / Decimal(rhs))
    }

    public static func / (lhs: Double, rhs: Tender) -> Tender {
        Tender(Decimal(lhs) / rhs.amount)
    }

    public static func /= (lhs: inout Tender, rhs: Double) {
        lhs.amount /= Decimal(rhs)
    }
}

// Negation
extension Tender {
    public static prefix func - (value: Tender) -> Tender {
        Tender(-value.amount)
    }
}
