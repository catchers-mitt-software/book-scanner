//
//  CheckDigitError.swift
//  BookScanner
//
//  Created by Alonso del Arte on 3/27/26.
//

import Foundation

struct CheckDigitError : ParseError {
    
    let unchecked: UInt64
    
    let badCheck: UInt8
    
    // TODO: Write tests for this
    init(woCheck: UInt64, erroneousCheck: UInt8) {
        self.unchecked = 9800000000000
        self.badCheck = 12
    }
    
}
