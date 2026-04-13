//
//  ISBNParseResultTest.swift
//  BookScannerTests
//
//  Created by Alonso del Arte on 4/10/26.
//

import Testing

struct ISBNParseResultTest {
    
    private static func choosePrefix() -> UInt64 {
        if Bool.random() {
            978
        } else {
            979
        }
    }
    
    private static func chooseAssignedDigits() -> UInt64 {
        let prefix = choosePrefix()
        let minimum = prefix * 1000000000
        let maximum = minimum + 999999000
        return UInt64.random(in: minimum ... maximum)
    }
    
    private static func chooseISBN13Digits() -> UInt64 {
        let num = chooseAssignedDigits()
        let check = ISBN.reckonISBN13CheckDigit(num)
        return 10 * num + UInt64(check)
    }

    @Test func testNumericConstructorISBN13() {
        let number = ISBNParseResultTest.chooseISBN13Digits()
        let expected = ISBN(number)
        let actual = ISBNParseResult(number).isbn
        #expect(actual == expected)
    }

}
