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
    
    // TODO: Write tests for this
    init(_ num: UInt64) {
        self.isbn = ISBN(0)
        self.problem = nil
    }
    
    // TODO: Write tests for this
    init(_ s: String) {
        self.isbn = ISBN(0)
        self.problem = nil
    }
    
}
