//
//  TestHelpers.swift
//
//  Created by António Nunes on 28/05/2023.
//  This file/code is in the public domain.
//

import XCTest

public enum TestError: Error {
    case unexpectedNilVariable
}

public func unwrapAndAssertNotNil<T>(_ variable: T?,
                              message: String = "Unexpected nil variable",
                              file: StaticString = #file,
                              line: UInt = #line) throws -> T {
    guard let variable else {
        XCTFail(message, file: file, line: line)
        throw TestError.unexpectedNilVariable
    }
    return variable
}

