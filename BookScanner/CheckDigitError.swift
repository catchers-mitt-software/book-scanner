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
    
    init(_ woCheck: UInt64, erroneousCheck: UInt8) {
        self.unchecked = woCheck
        self.badCheck = erroneousCheck
    }
    
}
