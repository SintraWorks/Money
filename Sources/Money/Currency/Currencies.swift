//
//  Currencies.swift
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

public enum AFN: Currency {}
public enum ALL: Currency {}
public enum AMD: Currency {}
public enum ANG: Currency {}
public enum AOA: Currency {}
public enum ARS: Currency {}
public enum AUD: Currency {}
public enum AWG: Currency {}
public enum AZN: Currency {}
public enum BAM: Currency {}
public enum BBD: Currency {}
public enum BDT: Currency {}
public enum BGN: Currency {}
public enum BHD: Currency { public static var minorUnitScale: Int { 3 } }
public enum BIF: Currency { public static var minorUnitScale: Int { 0 } }
public enum BMD: Currency {}
public enum BND: Currency {}
public enum BOB: Currency {}
public enum BRL: Currency {}
public enum BSD: Currency {}
public enum BTN: Currency {}
public enum BWP: Currency {}
public enum BYN: Currency {}
public enum BZD: Currency {}
public enum CAD: Currency {}
public enum CDF: Currency {}
public enum CHF: Currency {}
public enum CLP: Currency { public static var minorUnitScale: Int { 0 } }
public enum CNY: Currency {}
public enum COP: Currency {}
public enum CRC: Currency {}
public enum CUC: Currency {}
public enum CUP: Currency {}
public enum CVE: Currency {}
public enum CZK: Currency {}
public enum DJF: Currency { public static var minorUnitScale: Int { 0 } }
public enum DKK: Currency {}
public enum DOP: Currency {}
public enum DZD: Currency {}
public enum EGP: Currency {}
public enum ERN: Currency {}
public enum ETB: Currency {}
public enum EUR: Currency {}
public enum FJD: Currency {}
public enum FKP: Currency {}
public enum GBP: Currency {}
public enum GEL: Currency {}
public enum GHS: Currency {}
public enum GIP: Currency {}
public enum GMD: Currency {}
public enum GNF: Currency { public static var minorUnitScale: Int { 0 } }
public enum GTQ: Currency {}
public enum GYD: Currency {}
public enum HKD: Currency {}
public enum HNL: Currency {}
public enum HRK: Currency {}
public enum HTG: Currency {}
public enum HUF: Currency {}
public enum IDR: Currency {}
public enum ILS: Currency {}
public enum INR: Currency {}
public enum IQD: Currency { public static var minorUnitScale: Int { 3 } }
public enum IRR: Currency {}
public enum ISK: Currency { public static var minorUnitScale: Int { 0 } }
public enum JMD: Currency {}
public enum JOD: Currency { public static var minorUnitScale: Int { 3 } }
public enum JPY: Currency { public static var minorUnitScale: Int { 0 } }
public enum KES: Currency {}
public enum KGS: Currency {}
public enum KHR: Currency {}
public enum KMF: Currency { public static var minorUnitScale: Int { 0 } }
public enum KPW: Currency {}
public enum KRW: Currency { public static var minorUnitScale: Int { 0 } }
public enum KWD: Currency { public static var minorUnitScale: Int { 3 } }
public enum KYD: Currency {}
public enum KZT: Currency {}
public enum LAK: Currency {}
public enum LBP: Currency {}
public enum LKR: Currency {}
public enum LRD: Currency {}
public enum LSL: Currency {}
public enum LYD: Currency { public static var minorUnitScale: Int { 3 } }
public enum MAD: Currency {}
public enum MDL: Currency {}
public enum MGA: Currency {}
public enum MKD: Currency {}
public enum MMK: Currency {}
public enum MNT: Currency {}
public enum MOP: Currency {}
public enum MRU: Currency {}
public enum MUR: Currency {}
public enum MVR: Currency {}
public enum MWK: Currency {}
public enum MXN: Currency {}
public enum MYR: Currency {}
public enum MZN: Currency {}
public enum NAD: Currency {}
public enum NGN: Currency {}
public enum NIO: Currency {}
public enum NOK: Currency {}
public enum NPR: Currency {}
public enum NZD: Currency {}
public enum OMR: Currency { public static var minorUnitScale: Int { 3 } }
public enum PAB: Currency {}
public enum PEN: Currency {}
public enum PGK: Currency {}
public enum PHP: Currency {}
public enum PKR: Currency {}
public enum PLN: Currency {}
public enum PYG: Currency { public static var minorUnitScale: Int { 0 } }
public enum QAR: Currency {}
public enum RON: Currency {}
public enum RSD: Currency {}
public enum RUB: Currency {}
public enum RWF: Currency { public static var minorUnitScale: Int { 0 } }
public enum SAR: Currency {}
public enum SBD: Currency {}
public enum SCR: Currency {}
public enum SDG: Currency {}
public enum SEK: Currency {}
public enum SGD: Currency {}
public enum SHP: Currency {}
public enum SLL: Currency {}
public enum SOS: Currency {}
public enum SRD: Currency {}
public enum SSP: Currency {}
public enum STN: Currency {}
public enum SYP: Currency {}
public enum SZL: Currency {}
public enum THB: Currency {}
public enum TJS: Currency {}
public enum TMT: Currency {}
public enum TND: Currency { public static var minorUnitScale: Int { 3 } }
public enum TOP: Currency {}
public enum TRY: Currency {}
public enum TTD: Currency {}
public enum TWD: Currency {}
public enum TZS: Currency {}
public enum UAH: Currency {}
public enum UGX: Currency { public static var minorUnitScale: Int { 0 } }
public enum USD: Currency {}
public enum UYU: Currency {}
public enum UZS: Currency {}
public enum VEF: Currency {}
public enum VES: Currency {}
public enum VND: Currency { public static var minorUnitScale: Int { 0 } }
public enum VUV: Currency { public static var minorUnitScale: Int { 0 } }
public enum WST: Currency {}
public enum XAF: Currency { public static var minorUnitScale: Int { 0 } }
public enum XCD: Currency {}
public enum XOF: Currency { public static var minorUnitScale: Int { 0 } }
public enum XPF: Currency {}
public enum YER: Currency {}
public enum ZAR: Currency {}
public enum ZMW: Currency {}

public enum SupportedCurrency: String, CaseIterable {
    case
    AFN,
    ALL,
    AMD,
    ANG,
    AOA,
    ARS,
    AUD,
    AWG,
    AZN,
    BAM,
    BBD,
    BDT,
    BGN,
    BHD,
    BIF,
    BMD,
    BND,
    BOB,
    BRL,
    BSD,
    BTN,
    BWP,
    BYN,
    BZD,
    CAD,
    CDF,
    CHF,
    CLP,
    CNY,
    COP,
    CRC,
    CUC,
    CUP,
    CVE,
    CZK,
    DJF,
    DKK,
    DOP,
    DZD,
    EGP,
    ERN,
    ETB,
    EUR,
    FJD,
    FKP,
    GBP,
    GEL,
    GHS,
    GIP,
    GMD,
    GNF,
    GTQ,
    GYD,
    HKD,
    HNL,
    HRK,
    HTG,
    HUF,
    IDR,
    ILS,
    INR,
    IQD,
    IRR,
    ISK,
    JMD,
    JOD,
    JPY,
    KES,
    KGS,
    KHR,
    KMF,
    KPW,
    KRW,
    KWD,
    KYD,
    KZT,
    LAK,
    LBP,
    LKR,
    LRD,
    LSL,
    LYD,
    MAD,
    MDL,
    MGA,
    MKD,
    MMK,
    MNT,
    MOP,
    MRU,
    MUR,
    MVR,
    MWK,
    MXN,
    MYR,
    MZN,
    NAD,
    NGN,
    NIO,
    NOK,
    NPR,
    NZD,
    OMR,
    PAB,
    PEN,
    PGK,
    PHP,
    PKR,
    PLN,
    PYG,
    QAR,
    RON,
    RSD,
    RUB,
    RWF,
    SAR,
    SBD,
    SCR,
    SDG,
    SEK,
    SGD,
    SHP,
    SLL,
    SOS,
    SRD,
    SSP,
    STN,
    SYP,
    SZL,
    THB,
    TJS,
    TMT,
    TND,
    TOP,
    TRY,
    TTD,
    TWD,
    TZS,
    UAH,
    UGX,
    USD,
    UYU,
    UZS,
    VEF,
    VES,
    VND,
    VUV,
    WST,
    XAF,
    XCD,
    XOF,
    XPF,
    YER,
    ZAR,
    ZMW
}
