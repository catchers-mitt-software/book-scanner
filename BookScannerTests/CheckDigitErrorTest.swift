//
//  CheckDigitErrorTest.swift
//  BookScannerTests
//
//  Created by Alonso del Arte on 4/3/26.
//

import Testing

struct CheckDigitErrorTest {
    
    private static func chooseDigitOtherThan(_ digit: UInt8) -> UInt8 {
        var propDigit = digit
        while (propDigit == digit) {
            propDigit = UInt8.random(in: 0 ... 9)
        }
        return propDigit
    }

    @Test func testWoCheck() {
        let correctCheckDigit = UInt8.random(in: 0 ... 9)
        let prefix = ISBNTest.choosePrefix()
        let expected = ISBNTest.chooseNumber(prefix, correctCheckDigit)
        let badCheck = CheckDigitErrorTest
            .chooseDigitOtherThan(correctCheckDigit)
        let instance = CheckDigitError(expected, erroneousCheck: badCheck)
        let actual = instance.unchecked
        #expect(actual == expected)
    }

}
