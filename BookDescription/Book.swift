//
//  Book.swift
//  BookScanner
//
//  Created by Alonso del Arte on 12/19/25.
//

import Foundation

struct Book : Decodable, Identifiable {
    
    var id: String { isbn }
    
    let title: String
    
    let author: String
    
    let publisher: String
    
    let year: Int
    
    let isbn: String
    
}
