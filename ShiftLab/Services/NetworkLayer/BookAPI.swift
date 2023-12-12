//
//  KontestsAPI.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 10.12.2023.
//

import Foundation
import Combine

enum BookAPIError: Error {
    case invalidURL
    case dataTaskError(Error)
    case noData
    case decodingError(Error)
}

class BookAPI {
    static let shared = BookAPI()
    private let endpoint = "https://fakerapi.it/api/v1/books"

    private init() {}

    func fetchData() -> AnyPublisher<[Book], BookAPIError> {
        guard let url = URL(string: endpoint) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error in
                    .dataTaskError(error)
            }
            .flatMap { data, _ in
                Just(data)
                    .decode(type: BookData.self, decoder: JSONDecoder())
                    .mapError { error in
                            .decodingError(error)
                    }
            }
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
