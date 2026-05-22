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
    
    @Test func testNumericConstructorRejectsInvalidISBN13Check() {
        let num = ISBNParseResultTest.chooseAssignedDigits()
        let check = ISBN.reckonISBN13CheckDigit(num)
        let expected = (check == 9) ? 0 : check + 1
        let badNumber = 10 * num + UInt64(expected)
        let instance = ISBNParseResult(badNumber)
        let message: Comment = "Invalid ISBN \(badNumber) should be rejected"
        #expect(instance.isbn == nil, message)
        if instance.problem is CheckDigitError {
            #expect((instance.problem as! CheckDigitError).badCheck == expected,
                    message)
        } // TODO: Test if instance.problem is not CheckDigitError
    }
    
    /// Test that the numeric constructor accepts a valid ISBN-10 number but
    /// converts it to ISBN-13. Obviously we can't test this for ISBN-10 numbers
    /// with check digit X.
    @Test func testNumericConstructorAcceptsValidISBN10AndConvertsToISBN13() {
        for check: UInt8 in (0 ... 9) {
            let num = 10 * ISBNTest.chooseISBN10(check) + UInt64(check)
            let instance = ISBNParseResult(num)
            let expected = ISBN(num)
            let actual = instance.isbn
            let message: Comment = "ISBN-10 \(num) should convert to ISBN-13"
            #expect(instance.problem == nil, message)
            #expect(expected == actual, message)
        }
    }

}
