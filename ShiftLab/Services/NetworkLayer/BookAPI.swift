//
//  KontestsAPI.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 10.12.2023.
//

import Foundation

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

    func fetchData(completion: @escaping (Result<[Book], BookAPIError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.dataTaskError(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(BookData.self, from: data)
                completion(.success(response.data))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            }
        }
        task.resume()
    }
}
