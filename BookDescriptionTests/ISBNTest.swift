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
    
    // TODO: Test conversion from ISBN-10 to ISBN-13
    // For example, Donald Knuth's The Art of Computer Programming, Volume I, as
    // published by Addison-Wesley in 1997, has ISBN-10 number 0201896834
    // (that's how the Wayne State University Library System website shows it to
    // me). According to https://www.isbn.org/ISBN_converter that converts to
    // ISBN-13 978-0-201-89683-1. Notice the prefix 978 is added, and all the
    // original digits are retained, except check digit 4 is discarded and the
    // check digit is recalculated as 1.

}
