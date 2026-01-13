//
//  ISBN.swift
//  BookScanner
//
//  Created by Alonso del Arte on 12/19/25.
//

struct ISBN : CustomStringConvertible {
    
    let digits: UInt64
    
    let checkDigit: UInt8
    
    var displayForm: String
    
    var description: String {
        self.displayForm
    }

    // TODO: Write tests for this
    // The idea here is that this function will mostly be used when converting
    // ISBN-10 numbers to ISBN-13. When an API responds with an ISBN-13 number,
    // it will be presumed valid.
    static func reckonISBN13CheckDigit(_ digits: UInt64) -> UInt8 {
        0
    }

    // TODO: Write tests for this
    init(_ number: UInt64) {
        self.digits = 0
        self.checkDigit = 0
        self.displayForm = "0"
    }
    
    // TODO: Write tests for this
    init(_ number: String) {
        self.digits = 0
        self.checkDigit = 0
        self.displayForm = "0"
    }
    
    private init(_ digits: UInt64, _ checkDigit: UInt8) {
        self.digits = 0
        self.checkDigit = 0
        self.displayForm = "0"
    }
    
}
