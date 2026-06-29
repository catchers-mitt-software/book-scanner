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
        let url = URL(string:
                        "https://openlibrary.org/search.json?q=\(isbn.description)&fields=title,author_name")
        let (data, _) = try await URLSession.shared.data(from: url!)
        let decoder = JSONDecoder()
        let response = try decoder.decode(OpenLibraryAPIResponse.self,
                                          from: data)
        if response.numFound > 0 {
            let title = response.docs[0].title
            let author = response.docs[0].author_name
            let book = Book(title: title, author_name: author,
                            isbn: isbn.description)
            books.insert(book, at: 0)
        }
    }
    
    private struct OpenLibraryAPIResponse : Decodable, Identifiable {
        
        var id: String { q }
        
        let numFound: Int
        
        let q: String
        
        let docs: [OpenLibraryDoc]
        
    }
    
    private struct OpenLibraryDoc : Decodable, Identifiable {
        
        var id: String { title }
        
        let author_name: [String]
        
        let title: String
        
    }
    
}
