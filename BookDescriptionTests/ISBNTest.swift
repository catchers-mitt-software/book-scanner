//
//  ISBNTest.swift
//  BookScannerTests
//
//  Created by Alonso del Arte on 1/5/26.
//
// To keep things simple for myself, in many of the tests involving numbers with
// dashes, I use registration group 0 even though there are lots of other
// registration groups.
//
// Note that some of these tests use numbers that are not valid ISBNs, as well
// as valid ISBNs with valid check digits but incorrect dash placements.
//

import Foundation
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
        let regStr = String(format: "%03d", registrant)
        let publication = UInt64.random(in: 0 ... 99999)
        let pubStr = String(format: "%05d", publication)
        let possibleCheck = UInt64.random(in: 0 ... 9)
        let s = "978-0-\(regStr)-\(pubStr)-\(possibleCheck)"
        let expected: UInt64 = 9780000000000 + registrant * 1000000 +
                publication * 10 + possibleCheck
        let actual: UInt64 = ISBN.removeDashes(s)
        #expect(actual == expected)
    }
    
    private static func chooseDiffCheckDigit(_ digit: UInt8) -> UInt8 {
        var prop = digit
        while prop == digit {
            prop = UInt8.random(in: 0 ... 9)
        }
        return prop
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
    
    private static func choosePrefix() -> UInt64 {
        let oldFlag = Bool.random()
        if oldFlag {
            return 978
        } else {
            return 979
        }
    }
    
    private static func chooseNumber() -> UInt64 {
        let prefix = choosePrefix()
        let check = UInt8.random(in: 0 ... 9)
        return 10 * chooseNumber(prefix, check) + UInt64(check)
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
    
    @Test func testReckonISBN13CheckDigitSixForPrefix978() {
        let expected: UInt8 = 6
        let digits = ISBNTest.chooseNumber(978, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitSixForPrefix979() {
        let expected: UInt8 = 6
        let digits = ISBNTest.chooseNumber(979, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitSevenForPrefix978() {
        let expected: UInt8 = 7
        let digits = ISBNTest.chooseNumber(978, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitSevenForPrefix979() {
        let expected: UInt8 = 7
        let digits = ISBNTest.chooseNumber(979, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitEightForPrefix978() {
        let expected: UInt8 = 8
        let digits = ISBNTest.chooseNumber(978, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitEightForPrefix979() {
        let expected: UInt8 = 8
        let digits = ISBNTest.chooseNumber(979, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitNineForPrefix978() {
        let expected: UInt8 = 9
        let digits = ISBNTest.chooseNumber(978, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
    
    @Test func testReckonISBN13CheckDigitNineForPrefix979() {
        let expected: UInt8 = 9
        let digits = ISBNTest.chooseNumber(979, expected)
        let actual = ISBN.reckonISBN13CheckDigit(digits)
        let message: Comment = "\(digits) should have check digit \(expected)"
        #expect(actual == expected, message)
    }
        
    @Test func testNumericConstructorSetsDigits() {
        let beginning = ISBNTest.choosePrefix() * 1000000000
        let woCheck = beginning + UInt64.random(in: 0 ... 999999000)
        let expected = 10 * woCheck + UInt64(ISBNTest.reckonCheckDigit(woCheck))
        let instance = ISBN(expected)
        let actual = instance.digits
        #expect(actual == expected)
    }
    
    @Test func testNumericConstructorSetsCheckDigit() {
        let prefix = ISBNTest.choosePrefix()
        let expected = UInt8.random(in: 0 ... 9)
        let woCheck = ISBNTest.chooseNumber(prefix, expected)
        let digits = 10 * woCheck + UInt64(expected)
        let instance = ISBN(digits)
        let actual = instance.checkDigit
        let message: Comment = "Getting check digit of \(digits)"
        #expect(actual == expected, message)
    }
    
    @Test func testNumericConstructorSetsDisplayFormNoDashes() {
        let number = ISBNTest.chooseNumber()
        let instance = ISBN(number)
        let expected = String(number)
        let actual = instance.displayForm
        #expect(actual == expected)
    }
    
    // TODO: Test numeric constructor rejects invalid check digit
    
    @Test func testStringConstructorSetsDigitsFromDashlessString() {
        let beginning = ISBNTest.choosePrefix() * 1000000000
        let woCheck = beginning + UInt64.random(in: 0 ... 999999000)
        let expected = 10 * woCheck + UInt64(ISBNTest.reckonCheckDigit(woCheck))
        let instance = ISBN(String(expected))
        let actual = instance.digits
        #expect(actual == expected)
    }
    
    @Test func testConstructorSetsDigitsFromStringWithDashes() {
        let prefix = ISBNTest.choosePrefix()
        let registrant = UInt64.random(in: 0 ... 999)
        let regStr = String(format: "%03d", registrant)
        let publication = UInt64.random(in: 0 ... 99999)
        let pubStr = String(format: "%05d", publication)
        let woCheckStr = "\(prefix)-0-\(regStr)-\(pubStr)-"
        let woCheckNum = ISBN.removeDashes(woCheckStr)
        let check = ISBNTest.reckonCheckDigit(woCheckNum)
        let numStr = woCheckStr + String(check)
        let instance = ISBN(numStr)
        let expected = 10 * woCheckNum + UInt64(check)
        let actual = instance.digits
        let message: Comment = "Getting digits for \"\(numStr)\""
        #expect(actual == expected, message)
    }
    
    @Test func testStringConstructorSetsCheckDigitFromDashlessString() {
        let beginning = ISBNTest.choosePrefix() * 1000000000
        let woCheck = beginning + UInt64.random(in: 0 ... 999999000)
        let expected = ISBNTest.reckonCheckDigit(woCheck)
        let numStr = String(10 * woCheck + UInt64(expected))
        let instance = ISBN(numStr)
        let actual = instance.checkDigit
        let message: Comment = "Getting check digit from \"\(numStr)\""
        #expect(actual == expected, message)
    }
    
    @Test func testStringConstructorSetsCheckDigitFromStringWithDashes() {
        let prefix = ISBNTest.choosePrefix()
        let registrant = UInt64.random(in: 0 ... 999)
        let regStr = String(format: "%03d", registrant)
        let publication = UInt64.random(in: 0 ... 99999)
        let pubStr = String(format: "%05d", publication)
        let woCheckStr = "\(prefix)-0-\(regStr)-\(pubStr)-"
        let woCheckNum = ISBN.removeDashes(woCheckStr)
        let expected = ISBNTest.reckonCheckDigit(woCheckNum)
        let numStr = woCheckStr + String(expected)
        let instance = ISBN(numStr)
        let actual = instance.checkDigit
        let message: Comment = "Getting check digit from \"\(numStr)\""
        #expect(actual == expected, message)
    }
    
    @Test func testStringConstructorSetsDisplayForm() {
        let prefix = ISBNTest.choosePrefix()
        let registrant = UInt64.random(in: 0 ... 999)
        let regStr = String(format: "%03d", registrant)
        let publication = UInt64.random(in: 0 ... 99999)
        let pubStr = String(format: "%05d", publication)
        let woCheckStr = "\(prefix)-0-\(regStr)-\(pubStr)-"
        let woCheckNum = ISBN.removeDashes(woCheckStr)
        let check = ISBNTest.reckonCheckDigit(woCheckNum)
        let expected = woCheckStr + String(check)
        let instance = ISBN(expected)
        let actual = instance.displayForm
        #expect(actual == expected)
    }
    
    // TODO: Test String constructor rejects invalid check digit
    
    @Test func testEquals() {
        let number = ISBNTest.chooseNumber()
        let someISBN = ISBN(number)
        let sameISBN = ISBN(number)
        #expect(someISBN == sameISBN)
    }
    
    @Test func testNotEquals() {
        let numberA = ISBNTest.chooseNumber()
        let isbnA = ISBN(numberA)
        let prefix = numberA / 10000000000
        let checkA = isbnA.checkDigit
        let checkB = ISBNTest.chooseDiffCheckDigit(checkA)
        let prelim = ISBNTest.chooseNumber(prefix, checkB)
        let numberB = 10 * prelim + UInt64(checkB)
        let isbnB = ISBN(numberB)
        #expect(isbnA != isbnB)
    }
    
    // TODO: Test conversion from ISBN-10 to ISBN-13
    // For example, Donald Knuth's The Art of Computer Programming, Volume I, as
    // published by Addison-Wesley in 1997, has ISBN-10 number 0201896834
    // (that's how the Wayne State University Library System website shows it to
    // me). According to https://www.isbn.org/ISBN_converter that converts to
    // ISBN-13 978-0-201-89683-1. Notice the prefix 978 is added, and all the
    // original digits are retained, except check digit 4 is discarded and the
    // check digit is recalculated as 1.
    
    /// Test that the constructor that takes a number converts a 10-digit number
    /// to ISBN-13. We will not worry whether the ISBN-10 number has a valid
    /// check digit or not.
    @Test func testNumericConstructorConvertsISBN10ToISBN13() {
        let number = UInt64.random(in: 0 ... 9999999999)
        let prefixedNumberNoCheck = 978000000000 + (number / 10)
        let check = ISBNTest.reckonCheckDigit(prefixedNumberNoCheck)
        let converted = 10 * prefixedNumberNoCheck + UInt64(check)
        let expected = ISBN(converted)
        let actual = ISBN(number)
        let message: Comment = "Number \(number) should convert to \(converted)"
        #expect(actual == expected, message)
    }
    
    @Test func testNumericConvertingConstructorSetsCheckDigit() {
        let number = UInt64.random(in: 0 ... 9999999999)
        let prefixedNumberNoCheck = 978000000000 + (number / 10)
        let expected = ISBNTest.reckonCheckDigit(prefixedNumberNoCheck)
        let converted = 10 * prefixedNumberNoCheck + UInt64(expected)
        let instance = ISBN(number)
        let actual = instance.checkDigit
        let message: Comment = "Check for \(number) converted to \(converted)"
        #expect(actual == expected, message)
    }
    
    @Test func testNumericConvertingConstructorSetsDisplayForm() {
        let number = UInt64.random(in: 0 ... 9999999999)
        let prefixedNumberNoCheck = 978000000000 + (number / 10)
        let check = ISBNTest.reckonCheckDigit(prefixedNumberNoCheck)
        let converted = 10 * prefixedNumberNoCheck + UInt64(check)
        let instance = ISBN(number)
        let expected = String(converted)
        let actual = instance.displayForm
        let message: Comment = "Display \(number) converted to \(converted)"
        #expect(actual == expected, message)
    }
    
    /// Test that the constructor that takes a `String` converts a 10-digit
    /// number to ISBN-13. We will not worry whether the ISBN-10 number has a
    /// valid check digit or not.
    @Test func testStringConstructorConvertsISBN10ToISBN13CheckDigit0To9() {
        let registrant = UInt64.random(in: 0 ... 999)
        let regStr = String(format: "%03d", registrant)
        let publication = UInt64.random(in: 0 ... 99999)
        let pubStr = String(format: "%05d", publication)
        let possibleCheck = UInt64.random(in: 0 ... 9)
        let s = "0-\(regStr)-\(pubStr)-\(possibleCheck)"
        let prelimISBN10 = UInt64(s.replacingOccurrences(of: "-", with: ""))!
        let prelimNoCheck = 978000000000 + (prelimISBN10 / 10)
        let check = ISBNTest.reckonCheckDigit(prelimNoCheck)
        let number = 10 * prelimNoCheck + UInt64(check)
        let expected = ISBN(number)
        let actual = ISBN(s)
        let message: Comment = "Getting ISBN-13 of maybe valid ISBN-10 \"\(s)\""
        #expect(actual == expected, message)
    }
        
    /// Test that the constructor that takes a `String` converts a 10-digit
    /// number to ISBN-13. We will not worry whether the ISBN-10 number has a
    /// valid check digit or not.
    @Test func testStringConstructorISBN10ToISBN13SetsCheckDigit() {
        let registrant = UInt64.random(in: 0 ... 999)
        let regStr = String(format: "%03d", registrant)
        let publication = UInt64.random(in: 0 ... 99999)
        let pubStr = String(format: "%05d", publication)
        let possibleCheck = UInt64.random(in: 0 ... 9)
        let s = "0-\(regStr)-\(pubStr)-\(possibleCheck)"
        let prelimISBN10 = UInt64(s.replacingOccurrences(of: "-", with: ""))!
        let prelimNoCheck = 978000000000 + (prelimISBN10 / 10)
        let expected = ISBNTest.reckonCheckDigit(prelimNoCheck)
        let instance = ISBN(s)
        let actual = instance.checkDigit
        let message: Comment = 
        "Getting ISBN-13 check digit of maybe valid ISBN-10 \"\(s)\""
        #expect(actual == expected, message)
    }
        
    /// Test that the constructor that takes a `String` converts a 10-digit
    /// number to ISBN-13. We will not worry whether the ISBN-10 number has a
    /// valid check digit or not.
    @Test func testStringConstructorConvertsISBN10CheckDigitXToISBN13() {
        let registrant = UInt64.random(in: 0 ... 999)
        let regStr = String(format: "%03d", registrant)
        let publication = UInt64.random(in: 0 ... 99999)
        let pubStr = String(format: "%05d", publication)
        let s = "0-\(regStr)-\(pubStr)-X"
        let noX = s.replacingOccurrences(of: "-X", with: "")
        let prelimISBN10 = UInt64(noX.replacingOccurrences(of: "-", with: ""))!
        let prelimNoCheck = 978000000000 + prelimISBN10
        let check = ISBNTest.reckonCheckDigit(prelimNoCheck)
        let number = 10 * prelimNoCheck + UInt64(check)
        let expected = ISBN(number)
        let actual = ISBN(s)
        let message: Comment = "Getting ISBN-13 of maybe valid ISBN-10 \"\(s)\""
        #expect(actual == expected, message)
    }
        
    // TODO: Test conversion from ISBN-10 to ISBN-13 retains original dashes
    
}
