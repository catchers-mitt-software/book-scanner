//
//  ContentView.swift
//  BookScanner
//
//  Created by Alonso del Arte on 12/19/25.
//

import SwiftUI
import VisionKit

struct ContentView: View {
    
    @StateObject var service = BookService()
    
    @State private var bookID = ""
    
    let viewController =
    DataScannerViewController(recognizedDataTypes: [.barcode()],
                              qualityLevel: .accurate,
                              recognizesMultipleItems: false,
                              isHighFrameRateTrackingEnabled: false,
                              isHighlightingEnabled: true)
    
    var body: some View {
        VStack {
            HStack {
                Text("Search by ISBN")
                TextField("e.g., 978-0-123-45670-0",
                          text: $bookID).onSubmit {
                    Task {
                        do {
                            try await service.getBook(isbn: ISBN(bookID))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            VStack {
                if !service.books.isEmpty {
                    Text(service.books[0].title).font(.largeTitle)
                    Text(service.books[0].author_name[0]).font(.subheadline)
                    AsyncImage(url: URL(string: BookService.bookCoverURL(isbn: ISBN(service.books[0].isbn))))
                }
//                List(service.books) { book in
//                    Text(book.title).font(.largeTitle)
//                    // if (movie.Poster != "N/A") {
//                        // AsyncImage(url: URL(string: movie.Poster))
//                    // }
//                    Text(book.author)
//                }
            }
        }
        .padding()
    }
    
}

#Preview {
    ContentView()
}
