//
//  Year.swift
//  BookScanner
//
//  Created by Alonso del Arte on 12/19/25.
//

struct Year {
    
    private let isoYear: Int16
    
    func description() -> String {
        self.isoYear.description
    }
    
    init(yyyy: Int16) {
        self.isoYear = yyyy
    }
    
}
