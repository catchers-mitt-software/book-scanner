//
//  YearTest.swift
//  BookScannerTests
//
//  Created by Alonso del Arte on 12/20/25.
//

import Testing

struct YearTest {

    @Test func testDescription() {
        let isoYear = Int16.random(in: 1600 ... 2400)
        let instance = Year(yyyy: isoYear)
        let expected = isoYear.description
        let actual = instance.description()
        #expect(expected == actual)
    }

}
