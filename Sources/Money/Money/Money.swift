//
//  Money.swift
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

/// A protocol that models the essentials of monetary amounts in specific currencies.
public protocol Money: Comparable, Codable {
    /// The amount that an instance represents.
    var amount: Decimal { get set }
    /// The currency that this instance represents.
    var currency: Currency.Type { get }
    ///  An agent that provides conveniences for displaying money as strings
    var displayable: any Displayable { get }

    /// The amount rounded to the currency's `minorUnitScale`.
    ///
    /// For example: A Euro based instance might hold an amount whose subvalue represents values smaller than a euro cent, say €24,108.
    /// Since the Euro only knows two places after the separator (scale = 2), `roundedAmount` will return `24,11`
    var roundedAmount: Decimal { get }
    /// Answers the question whether the held amount is negative.
    var isNegative: Bool { get }
    /// Returns the major units in the amount, discarding the minor units
    ///
    /// E.g: if the amount is 3.14, `majorUnits` returns 3.
    var majorUnits: Decimal { get }
    /// Returns the minor units, discarding the major units.
    ///
    /// E.g: if the amount is 3.14, `minorUnits` returns 0.14.
    var minorUnits: Decimal { get }
}

/// A convenience facilitating the creation of monetary amounts at run-time from a combination of amounts and currencodes.
enum MoneyFactory {
    /// Creates a concrete instance of a monetary amount (a `Tender`) from the provided amount and currency.
    public static func moneyFrom(amount: Decimal, currency: SupportedCurrency) throws -> any Money {
        switch currency {
            case .AFN: return Tender<AFN>(amount)
            case .ALL: return Tender<ALL>(amount)
            case .AMD: return Tender<AMD>(amount)
            case .ANG: return Tender<ANG>(amount)
            case .AOA: return Tender<AOA>(amount)
            case .ARS: return Tender<ARS>(amount)
            case .AUD: return Tender<AUD>(amount)
            case .AWG: return Tender<AWG>(amount)
            case .AZN: return Tender<AZN>(amount)
            case .BAM: return Tender<BAM>(amount)
            case .BBD: return Tender<BBD>(amount)
            case .BDT: return Tender<BDT>(amount)
            case .BGN: return Tender<BGN>(amount)
            case .BHD: return Tender<BHD>(amount)
            case .BIF: return Tender<BIF>(amount)
            case .BMD: return Tender<BMD>(amount)
            case .BND: return Tender<BND>(amount)
            case .BOB: return Tender<BOB>(amount)
            case .BRL: return Tender<BRL>(amount)
            case .BSD: return Tender<BSD>(amount)
            case .BTN: return Tender<BTN>(amount)
            case .BWP: return Tender<BWP>(amount)
            case .BYN: return Tender<BYN>(amount)
            case .BZD: return Tender<BZD>(amount)
            case .CAD: return Tender<CAD>(amount)
            case .CDF: return Tender<CDF>(amount)
            case .CHF: return Tender<CHF>(amount)
            case .CLP: return Tender<CLP>(amount)
            case .CNY: return Tender<CNY>(amount)
            case .COP: return Tender<COP>(amount)
            case .CRC: return Tender<CRC>(amount)
            case .CUC: return Tender<CUC>(amount)
            case .CUP: return Tender<CUP>(amount)
            case .CVE: return Tender<CVE>(amount)
            case .CZK: return Tender<CZK>(amount)
            case .DJF: return Tender<DJF>(amount)
            case .DKK: return Tender<DKK>(amount)
            case .DOP: return Tender<DOP>(amount)
            case .DZD: return Tender<DZD>(amount)
            case .EGP: return Tender<EGP>(amount)
            case .ERN: return Tender<ERN>(amount)
            case .ETB: return Tender<ETB>(amount)
            case .EUR: return Tender<EUR>(amount)
            case .FJD: return Tender<FJD>(amount)
            case .FKP: return Tender<FKP>(amount)
            case .GBP: return Tender<GBP>(amount)
            case .GEL: return Tender<GEL>(amount)
            case .GHS: return Tender<GHS>(amount)
            case .GIP: return Tender<GIP>(amount)
            case .GMD: return Tender<GMD>(amount)
            case .GNF: return Tender<GNF>(amount)
            case .GTQ: return Tender<GTQ>(amount)
            case .GYD: return Tender<GYD>(amount)
            case .HKD: return Tender<HKD>(amount)
            case .HNL: return Tender<HNL>(amount)
            case .HRK: return Tender<HRK>(amount)
            case .HTG: return Tender<HTG>(amount)
            case .HUF: return Tender<HUF>(amount)
            case .IDR: return Tender<IDR>(amount)
            case .ILS: return Tender<ILS>(amount)
            case .INR: return Tender<INR>(amount)
            case .IQD: return Tender<IQD>(amount)
            case .IRR: return Tender<IRR>(amount)
            case .ISK: return Tender<ISK>(amount)
            case .JMD: return Tender<JMD>(amount)
            case .JOD: return Tender<JOD>(amount)
            case .JPY: return Tender<JPY>(amount)
            case .KES: return Tender<KES>(amount)
            case .KGS: return Tender<KGS>(amount)
            case .KHR: return Tender<KHR>(amount)
            case .KMF: return Tender<KMF>(amount)
            case .KPW: return Tender<KPW>(amount)
            case .KRW: return Tender<KRW>(amount)
            case .KWD: return Tender<KWD>(amount)
            case .KYD: return Tender<KYD>(amount)
            case .KZT: return Tender<KZT>(amount)
            case .LAK: return Tender<LAK>(amount)
            case .LBP: return Tender<LBP>(amount)
            case .LKR: return Tender<LKR>(amount)
            case .LRD: return Tender<LRD>(amount)
            case .LSL: return Tender<LSL>(amount)
            case .LYD: return Tender<LYD>(amount)
            case .MAD: return Tender<MAD>(amount)
            case .MDL: return Tender<MDL>(amount)
            case .MGA: return Tender<MGA>(amount)
            case .MKD: return Tender<MKD>(amount)
            case .MMK: return Tender<MMK>(amount)
            case .MNT: return Tender<MNT>(amount)
            case .MOP: return Tender<MOP>(amount)
            case .MRU: return Tender<MRU>(amount)
            case .MUR: return Tender<MUR>(amount)
            case .MVR: return Tender<MVR>(amount)
            case .MWK: return Tender<MWK>(amount)
            case .MXN: return Tender<MXN>(amount)
            case .MYR: return Tender<MYR>(amount)
            case .MZN: return Tender<MZN>(amount)
            case .NAD: return Tender<NAD>(amount)
            case .NGN: return Tender<NGN>(amount)
            case .NIO: return Tender<NIO>(amount)
            case .NOK: return Tender<NOK>(amount)
            case .NPR: return Tender<NPR>(amount)
            case .NZD: return Tender<NZD>(amount)
            case .OMR: return Tender<OMR>(amount)
            case .PAB: return Tender<PAB>(amount)
            case .PEN: return Tender<PEN>(amount)
            case .PGK: return Tender<PGK>(amount)
            case .PHP: return Tender<PHP>(amount)
            case .PKR: return Tender<PKR>(amount)
            case .PLN: return Tender<PLN>(amount)
            case .PYG: return Tender<PYG>(amount)
            case .QAR: return Tender<QAR>(amount)
            case .RON: return Tender<RON>(amount)
            case .RSD: return Tender<RSD>(amount)
            case .RUB: return Tender<RUB>(amount)
            case .RWF: return Tender<RWF>(amount)
            case .SAR: return Tender<SAR>(amount)
            case .SBD: return Tender<SBD>(amount)
            case .SCR: return Tender<SCR>(amount)
            case .SDG: return Tender<SDG>(amount)
            case .SEK: return Tender<SEK>(amount)
            case .SGD: return Tender<SGD>(amount)
            case .SHP: return Tender<SHP>(amount)
            case .SLL: return Tender<SLL>(amount)
            case .SOS: return Tender<SOS>(amount)
            case .SRD: return Tender<SRD>(amount)
            case .SSP: return Tender<SSP>(amount)
            case .STN: return Tender<STN>(amount)
            case .SYP: return Tender<SYP>(amount)
            case .SZL: return Tender<SZL>(amount)
            case .THB: return Tender<THB>(amount)
            case .TJS: return Tender<TJS>(amount)
            case .TMT: return Tender<TMT>(amount)
            case .TND: return Tender<TND>(amount)
            case .TOP: return Tender<TOP>(amount)
            case .TRY: return Tender<TRY>(amount)
            case .TTD: return Tender<TTD>(amount)
            case .TWD: return Tender<TWD>(amount)
            case .TZS: return Tender<TZS>(amount)
            case .UAH: return Tender<UAH>(amount)
            case .UGX: return Tender<UGX>(amount)
            case .USD: return Tender<USD>(amount)
            case .UYU: return Tender<UYU>(amount)
            case .UZS: return Tender<UZS>(amount)
            case .VEF: return Tender<VEF>(amount)
            case .VES: return Tender<VES>(amount)
            case .VND: return Tender<VND>(amount)
            case .VUV: return Tender<VUV>(amount)
            case .WST: return Tender<WST>(amount)
            case .XAF: return Tender<XAF>(amount)
            case .XCD: return Tender<XCD>(amount)
            case .XOF: return Tender<XOF>(amount)
            case .XPF: return Tender<XPF>(amount)
            case .YER: return Tender<YER>(amount)
            case .ZAR: return Tender<ZAR>(amount)
            case .ZMW: return Tender<ZMW>(amount)
        }
    }

    /// Uses the list of currency codes known to iOS to generate a string with Swift code defining types for those currencies.
    ///
    /// The ISO list of currency codes is maintained by SIX Financial Information AG. Follow this link and look for ISO 4217 to gain access to the list:
    /// [ISO 4217 maintenance](https://www.six-group.com/en/products-services/financial-information/data-standards.html)
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    public static func createCurrencies() -> String {
        // Since iOS doesn't provide info on the unit scale of each currency, we use a hard-coded list, that only represents currencies
        // that deviate from the, more or less standard, unit scale of 2.
        let nonDefaultUnitScales: [String: Int] = [
            "BHD": 3,
            "BIF": 0,
            "CLF": 4,
            "CLP": 0,
            "DJF": 0,
            "GNF": 0,
            "IQD": 3,
            "ISK": 0,
            "JOD": 3,
            "JPY": 0,
            "KMF": 0,
            "KRW": 0,
            "KWD": 3,
            "LYD": 3,
            "OMR": 3,
            "PYG": 0,
            "RWF": 0,
            "TND": 3,
            "UGX": 0,
            "UYI": 0,
            "UYW": 4,
            "VND": 0,
            "VUV": 0,
            "XAF": 0,
            "XOF": 0
        ]

        let commonISOCurrencyCodes = Locale.commonISOCurrencyCodes
        var swiftCurrencies = ""
        for currencyCode in commonISOCurrencyCodes {
            if let nonDefaultUnitScale = nonDefaultUnitScales[currencyCode] {
                swiftCurrencies += "public enum \(currencyCode): Currency { public static var minorUnitScale: Int { \(nonDefaultUnitScale) } }"
            } else {
                swiftCurrencies += "public enum \(currencyCode): Currency {}"
            }

            if currencyCode != commonISOCurrencyCodes.last {
                swiftCurrencies += "\n"
            }
        }

        swiftCurrencies += "\n"

        swiftCurrencies += "\npublic enum SupportedCurrency: String, CaseIterable {\n    case\n"
        for currencyCode in commonISOCurrencyCodes {
            swiftCurrencies += "    \(currencyCode)"
            if currencyCode != commonISOCurrencyCodes.last {
                swiftCurrencies += ",\n"
            }
        }
        swiftCurrencies += "\n}\n"

        return swiftCurrencies
    }
}
