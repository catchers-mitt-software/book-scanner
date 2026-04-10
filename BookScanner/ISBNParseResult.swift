//
//  ISBNParseResult.swift
//  BookScanner
//
//  Created by Alonso del Arte on 4/7/26.
//

import Foundation

struct ISBNParseResult {
    
    let isbn: ISBN?
    
    let problem: ParseError?
    
    // TODO: Write tests for this
    init(num: UInt64) {
        self.isbn = ISBN(0)
        self.problem = nil
    }
    
    // TODO: Write tests for this
    init(s: String) {
        self.isbn = ISBN(0)
        self.problem = nil
    }
    
}
