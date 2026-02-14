//
//  ISBN.swift
//  BookScanner
//
//  Created by Alonso del Arte on 12/19/25.
//

import Foundation

struct ISBN : CustomStringConvertible {
    
    let digits: UInt64
    
    let checkDigit: UInt8
    
    var displayForm: String
    
    var description: String {
        self.displayForm
    }
    
    static func removeDashes(_ s: String) -> UInt64 {
        let parsed = s.replacingOccurrences(of: "-", with: "")
        return UInt64(parsed)!
    }

    // TODO: Write tests for this
    // The idea here is that this function will mostly be used when converting
    // ISBN-10 numbers to ISBN-13. When an API responds with an ISBN-13 number,
    // it will be presumed valid.
    static func reckonISBN13CheckDigit(_ digits: UInt64) -> UInt8 {
        var multiplier: UInt64 = 3
        var curr: UInt64 = digits
        var sum: UInt64 = 0
        while (curr > 0) {
            let digit = curr % 10
            sum += digit * multiplier
            curr /= 10
            if (multiplier == 3) {
                multiplier = 1
            } else {
                multiplier = 3
            }
        }
        let modSum = sum % 10
        if (modSum == 0) {
            return 0
        }
        return UInt8(10 - modSum)
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
