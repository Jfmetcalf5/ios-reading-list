//
//  BookController.swift
//  Reading List
//
//  Created by Jacob Metcalf on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter({$0.hasBeenRead == true})
    }
    
    var unreadBooks: [Book] {
        return books.filter({$0.hasBeenRead == false})
    }
    
    func create(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenReadOn(book: Book) {
        guard let index = books.index(of: book) else { return }
        var scratch = book
        scratch.hasBeenRead = !book.hasBeenRead
        books.remove(at: index)
        books.insert(scratch, at: index)
        saveToPersistentStore()
    }
    
    func updateTitleAndReasonOf(book: Book, title: String, reasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        var scratch = book
        scratch.title = title
        scratch.reasonToRead = reasonToRead
        books.remove(at: index)
        books.insert(scratch, at: index)
        saveToPersistentStore()
    }
    
    var readingListURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = "ReadingList.plist"
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    func saveToPersistentStore() {
        let pListEncoder = PropertyListEncoder()
        do {
            let booksData = try pListEncoder.encode(books)
            guard let readingList = readingListURL else { return }
            try booksData.write(to: readingList)
        } catch let e {
            print("Error saving! \(e.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let readingList = readingListURL else { return }
            let booksData = try Data(contentsOf: readingList)
            let pListDecoder = PropertyListDecoder()
            let decodedBooks = try pListDecoder.decode([Book].self, from: booksData)
            self.books = decodedBooks
        } catch let e {
            print("Error loading from persistence! \(e.localizedDescription)")
        }
    }
    
}
