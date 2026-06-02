//
//  ISBNParseResult.swift
//  BookScanner
//
//  Created by Alonso del Arte on 4/7/26.
//

import Foundation

// The general idea here is that this object holds either a valid ISBN or an 
// error object
struct ISBNParseResult {
    
    let isbn: ISBN?
    
    let problem: ParseError?
    
    init(_ num: UInt64) {
        // TODO: Refactor to cut down on duplication
        if num < 9780000000000 {
            let assigned = num / 10
            let unverified = UInt8(num % 10)
            let checked = ISBN.reckonISBN10CheckDigit(assigned)
            if checked == unverified {
                self.isbn = ISBN(num)
                self.problem = nil
            } else {
                self.isbn = nil
                self.problem = CheckDigitError(assigned,
                                               erroneousCheck: unverified)
            }
        } else {
            let assigned = num / 10
            let unverified = UInt8(num % 10)
            let checked = ISBN.reckonISBN13CheckDigit(assigned)
            if checked == unverified {
                self.isbn = ISBN(num)
                self.problem = nil
            } else {
                self.isbn = nil
                self.problem = CheckDigitError(assigned,
                                               erroneousCheck: unverified)
            }
        }
    }
    
    // TODO: Write tests for this
    init(_ s: String) {
        self.isbn = ISBN(0)
        self.problem = nil
    }
    
}
