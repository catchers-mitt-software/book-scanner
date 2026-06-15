//
//  BookService.swift
//  BookScanner
//
//  Created by Alonso del Arte on 6/15/26.
//

import Foundation
internal import Combine

@MainActor
class BookService : ObservableObject {
    
    @Published var books: [Book] = []
    
    func getBook(isbn: ISBN) async throws {
        let url = URL(string: "https://bookapi.com")
        let (data, _) = try await URLSession.shared.data(from: url!)
        let decoder = JSONDecoder()
        let book = try decoder.decode(Book.self, from: data)
        books.insert(book, at: 0)
    }
    
}
