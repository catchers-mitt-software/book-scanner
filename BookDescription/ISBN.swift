//
//  ISBN.swift
//  BookScanner
//
//  Created by Alonso del Arte on 12/19/25.
//

struct ISBN {
    
    let digits: UInt64
    
    let checkDigit: UInt8
    
    // TODO: Write tests for this
    init(_ number: UInt64) {
        self.digits = 0
        self.checkDigit = 0
    }
    
    // TODO: Write tests for this
    init(_ number: String) {
        self.digits = 0
        self.checkDigit = 0
    }
    
    private init(_ digits: UInt64, _ checkDigit: UInt8) {
        self.digits = 0
        self.checkDigit = 0
    }
    
}
