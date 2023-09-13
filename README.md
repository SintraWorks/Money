# Money

Money is a package that facilitates the handling and display of currencies and monetary amounts.

### Goals

1. **Precision**: Allow handling of monetary amounts without loss of precision. This is achieved by using the `Decimal` type to represent amounts. Decimals do not suffer from the (potentially) imprecise representations that make floating point numbers inappropriate as a carrier for monetary amounts.
2. **Type safety**: Disallow arithmetical operations between monetary amounts of different currencies. This is achieved by making the concrete money type (`Tender`) generic over its currency, enabling compiler level support when dealing with money types.
3. Yet we must be flexible in allowing dynamic creation of concrete monetary amounts, and allowing collections that contain monetary amounts of varying currencies. This is achieved through the `Money` protocol.
4. **Convenience**: Working with monetary amounts should be as easy as working with built-in number types. This is achieved by adding provisions that facilitate day-to-day needs when dealing with monetary amounts.


### Implementation

Currencies are represented by caseless enums that conform to the Currency protocol. We use caseless enums since we want to use currencies as types only. We don't want instances of currencies, since we don't need them, and caseless enums cannot be instantiated. Currencies have a `code` and a `minorUnitScale`. The `minorUnitScale` represents the subdivisions of the main (major) currency unit. E.g: Euros and US Dollars are divided into cents, hence they have a `minorUnitScale` of `2`. Each currency also has a name. We derive the (localized) name from the platform, since Apple platforms provide this information.

We provide default implementations for all properties defined in the protocol to avoid code duplication. The only implementation that is expected to occasionally be overridden is that of the `minorUnitScale`. The vast majority of currencies have a unit scale of 2, but some currencies deviate from that. We provide a default list of known currencies, which, we expect, will seldom need to be updated. The list we provide is based on the common currencies known to the Apple platforms, and therefore is not guaranteed to be quite 100% equal to the ISO 4217 list of currencies, but the discrepancies, at the time of this writing are small enough to be negligeable to most. Yet, your needs may vary, so you may choose to alter the list to your needs.

For the represention of monetary amounts we use two related types: `Money`, a protocol that represents monetary amounts, and `Tender` a type that conforms to `Money`. `Tender` is generic over the currency it represents, which provides compiler assisted type safety (e.g. disallowing the addition of `Tender`s of different currencies), while its conformance to the `Money` protocol provides the needed flexibility to work with collections of money of various currencies, and run-time instantiation of monetary amounts whose currency is not known at compile-time.

Think of `Money` as the abstract type, providing dynamic flexibility at runtime, and of `Tender` as the concrete monetary amount that is tendered (offered) for processing.

While you cannot add or subtract `Tender`s of different currencies (which would make no sense without first converting them to the same currency), or multiply one `Tender` by another, you _can_ perform arithmetic on `Tender`s. E.g. you can multiply a `Tender` by a numeric type: €5.42 * 3,14.

### Usage

Currencies are already provided, so you should not need to create currencies. However, if, for whatever reason, you find you need to create custom currencies, you can create new currency types as enums that conform to the `Currency` protocol. If your custom unit needs a `minorUnitScale` that is not the standard `2`, then you need to provide a custom implementation in the body of the enum:

    public enum MyCustomCurrency: Currency { public static var minorUnitScale: Int { 4 } }
    
Otherwise, you can just create an enum with an empty body:
    
    public enum MyCustomCurrency: Currency {}
    
Create concrete monetary amounts by creating instances of `Tender`, providing the currency it is generic over. Preferably create `Tender`s from `Decimal`s, `Int`s or `String`s, rather than from floating point values, although you can use those if you really need to.

        let amount: Decimal = 3.14 // (or, preferably: Decimal(string: "3.14"))
        let someMoney1 = Tender<EUR>(amount)
        let someMoney2 = Tender<USD> = 5
        let someMoney3 = Tender<JPY> = 3000
        let someMoney4 = Tender<SEK>("42")
        let someMoney5 = Tender<USD>("5,501", locale: Locale(identifier: "nl_NL")
        let someMoney6 = Tender<USD>("5.501", locale: Locale(identifier: "en_US")

        let ratherNot = Tender<EUR>(3.02) // 3.02 cannot be represented accurately as a floating point number, hence the tender initiated from it will inherently be flawed.


You cannot add or subtract `Tender`s of different currencies. You can however add and subtract `Tender`s of the same currency:

        let sum = someMoney5 + someMoney6
        
You can also compare `Tender`s of the same currency:
        
        if someMoney5 < someMoney6 {
            …do something…
        }

Take a look at the TenderTests and TenderAlgebraTests files for a good overview of what is possible.

Of course, we will usually need to display our monetary amounts to our users. To this end, the `Money` type provides a `displayable`, of type `Displayable`, that facilitates the translation from the amount to user friendly strings. When you want to diplay an amount to the user, ask the instance for a `displayable`, and ask the `Displayable` for the desired string:

            someMoney5.displayable.formatted
            someMoney5.displayable.formattedTruncatingDecimals()
            someMoney5.displayable.formattedTruncatingDecimals(for: Locale(identifier: "en_GB")
            someMoney5.displayable.formattedWithoutCurrencySymbol()
            someMoney5.displayable.formattedWithoutCurrencySymbol(for: Locale(identifier: "pt_PT")

You can also ask a displayable for the currency symbol and decimal separator and currency name.

If you need to store collections of amounts with various currencies, you cannot create a collection of `Tender`, since `Tender` is generic over its currency. In this case you should create a collection of `Money`, since Money, while holding a currency, is not generic over it.
            
            var variousCurrencies = [any Money]()
            variousCurrencies.append(Tender<EUR>(1))
            variousCurrencies.append(Tender<USD>(0.5))
            
Additionally, if you need to create monetary amounts at runtime, whose currency you do not know at compile time, use the `Money` type to model your data. Use the `MoneyFactory` to obtain a concrete `Tender` (typed as `Money`) from an amount and currency code:

            let myRuntTimeAmount = Decimal(42)
            let myRuntimeCurrency = SupportedCurrency.INR
            
            try MoneyFactory.moneyFrom(amount: myRuntTimeAmount, currency: myRuntimeCurrency)

