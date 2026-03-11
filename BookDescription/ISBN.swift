//
//  ISBN.swift
//  BookScanner
//
//  Created by Alonso del Arte on 12/19/25.
//

import Foundation

/// WORK IN PROGRESS...
/// Represents an ISBN-13 number.
/// A means will be provided for converting ISBN-10 numbers
struct ISBN : CustomStringConvertible, Equatable {
    
    /// The digits of the ISBN-13 number, including the check digit.
    let digits: UInt64
    
    /// Just the check digit of the ISBN-13 number.
    let checkDigit: UInt8
    
    var displayForm: String
    
    var description: String {
        self.displayForm
    }
    
    static func removeDashes(_ s: String) -> UInt64 {
        let parsed = s.replacingOccurrences(of: "-", with: "")
        return UInt64(parsed)!
    }

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
    
    static func == (lhs: ISBN, rhs: ISBN) -> Bool {
        lhs.digits == rhs.digits
    }

    init(_ number: UInt64) {
        if (number < 9780000000000) {
            let prefixed = 978000000000 + (number / 10)
            let check = ISBN.reckonISBN13CheckDigit(prefixed)
            self.digits = 10 * prefixed + UInt64(check)
            self.checkDigit = check
            self.displayForm = String(self.digits)
        } else {
            self.digits = number
            self.checkDigit = UInt8(self.digits % 10)
            self.displayForm = String(number)
        }
    }
    
    init(_ number: String) {
        self.digits = UInt64(ISBN.removeDashes(number))
        self.checkDigit = UInt8(self.digits % 10)
        self.displayForm = number
    }
    
    private init(_ digs: UInt64, _ check: UInt8, _ disp: String) {
        self.digits = 0
        self.checkDigit = 13
        self.displayForm = "0"
    }
    
}
