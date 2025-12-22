//
//  YearTest.swift
//  BookScannerTests
//
//  Created by Alonso del Arte on 12/20/25.
//

import Testing

struct YearTest {

    @Test func placeholder() async throws {
        let x = 4
        let y = 3
        let expected = x + y
        let actual = x * y
        #expect(expected == actual)
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
