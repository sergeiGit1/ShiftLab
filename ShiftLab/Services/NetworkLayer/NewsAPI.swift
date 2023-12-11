//
//  KontestsAPI.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 10.12.2023.
//

import Foundation

enum NewsAPIError: Error {
    case invalidURL
    case dataTaskError(Error)
    case noData
    case decodingError(Error)
}

class NewsAPI {
    static let shared = NewsAPI()

    private init() {}

    func fetchData(completion: @escaping (Result<[Article], NewsAPIError>) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=keyword&apiKey=f11f62acc6bc4ec08afc9b604c3b79c6") else {
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
                let response = try decoder.decode(NewsResponse.self, from: data)
                completion(.success(response.articles))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            }
        }
        task.resume()
    }
}
