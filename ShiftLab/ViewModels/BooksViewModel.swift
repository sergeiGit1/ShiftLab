//
//  NewsViewModel.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 11.12.2023.
//

import Foundation
import Combine

class BooksViewModel {
    private let bookAPI = BookAPI.shared
    @Published var books: [Book] = []
    
    var cancellables = Set<AnyCancellable>()
    
    
    func getBooksCount() -> Int {
        return books.count
    }

    func getBook(at index: Int) -> Book {
        return books[index]
    }

    func getData() {
        bookAPI.fetchData()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] fetchedBooks in
                self?.books = fetchedBooks
            })
            .store(in: &cancellables)
    }
}



