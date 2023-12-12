//
//  NewsViewModel.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 11.12.2023.
//

import Foundation

class BooksViewModel {
    private let bookAPI = BookAPI.shared
    var onDataUpdate: (() -> Void)?
    var books: [Book] = [] {
        didSet {
            onDataUpdate?()
        }
    }
    
    func getBooksCount() -> Int {
        return books.count
    }

    func getBook(at index: Int) -> Book {
        return books[index]
    }

    func getData() {
        bookAPI.fetchData { [weak self] result in
            switch result {
            case .success(let fetchedBooks):
                self?.books = fetchedBooks
            case .failure(let failure):
                print("\(failure)")
            }
        }
    }
}



