//
//  ISBNTest.swift
//  BookScannerTests
//
//  Created by Alonso del Arte on 1/5/26.
//
// Note that some of these tests use numbers that are not valid ISBNs, as well
// as valid ISBNs with valid check digits but incorrect dash placements.
//

import Testing

struct ISBNTest {
    
    @Test func testRemoveDashesWhenThereAreNoneToRemove() {
        let expected: UInt64 = 9780000000000 +
                UInt64.random(in: 0 ... 10000000000)
        let numStr: String = expected.description
        let actual: UInt64 = ISBN.removeDashes(numStr)
        #expect(actual == expected)
    }
    
    @Test func testRemoveDashes() {
        let registrant = UInt64.random(in: 0 ... 999)
        let publication = UInt64.random(in: 0 ... 99999)
        let possibleCheck = UInt64.random(in: 0 ... 9)
        let s = "978-0-\(registrant)-\(publication)-\(possibleCheck)"
        let expected: UInt64 = 9780000000000 + registrant * 1000000 +
                publication * 10 + possibleCheck
        let actual: UInt64 = ISBN.removeDashes(s)
        #expect(actual == expected)
    }
    
    private static func reckonCheckDigit(_ num: UInt64) -> UInt8 {
        var multiplier: UInt64 = 3
        var curr: UInt64 = num
        var sum: UInt64 = 0
        while (curr > 0) {
            let digit = curr % 10
            sum += digit * multiplier
            curr /= 10
            if (multiplier == 3) {
                multiplier = 1
            } else {
                multiplier = 3
            }
        }
        let modSum = sum % 10
        if (modSum == 0) {
            return 0
        }
        return UInt8(10 - modSum)
    }
    
    private static func chooseNumber(_ prefix: UInt64, _ check: UInt8)
    -> UInt64 {
        let minimum = prefix * 1000000000
        let maximum = minimum + 999999000
        var propNum = UInt64.random(in: minimum ... maximum)
        while (reckonCheckDigit(propNum) != check) {
            propNum += 1
        }
        return propNum
    }
    
    @Test func testReckonISBN13CheckDigitZeroForPrefix978() {
        let expected: UInt8 = 0
        let digits = ISBNTest.chooseNumber(978, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitZeroForPrefix979() {
        let expected: UInt8 = 0
        let digits = ISBNTest.chooseNumber(979, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitOneForPrefix978() {
        let expected: UInt8 = 1
        let digits = ISBNTest.chooseNumber(978, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitOneForPrefix979() {
        let expected: UInt8 = 1
        let digits = ISBNTest.chooseNumber(979, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitTwoForPrefix978() {
        let expected: UInt8 = 2
        let digits = ISBNTest.chooseNumber(978, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitTwoForPrefix979() {
        let expected: UInt8 = 2
        let digits = ISBNTest.chooseNumber(979, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitThreeForPrefix978() {
        let expected: UInt8 = 3
        let digits = ISBNTest.chooseNumber(978, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitThreeForPrefix979() {
        let expected: UInt8 = 3
        let digits = ISBNTest.chooseNumber(979, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitFourForPrefix978() {
        let expected: UInt8 = 4
        let digits = ISBNTest.chooseNumber(978, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitFourForPrefix979() {
        let expected: UInt8 = 4
        let digits = ISBNTest.chooseNumber(979, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitFiveForPrefix978() {
        let expected: UInt8 = 5
        let digits = ISBNTest.chooseNumber(978, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitFiveForPrefix979() {
        let expected: UInt8 = 5
        let digits = ISBNTest.chooseNumber(979, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    // TODO: Test conversion from ISBN-10 to ISBN-13
    // For example, Donald Knuth's The Art of Computer Programming, Volume I, as
    // published by Addison-Wesley in 1997, has ISBN-10 number 0201896834
    // (that's how the Wayne State University Library System website shows it to
    // me). According to https://www.isbn.org/ISBN_converter that converts to
    // ISBN-13 978-0-201-89683-1. Notice the prefix 978 is added, and all the
    // original digits are retained, except check digit 4 is discarded and the
    // check digit is recalculated as 1.

}
