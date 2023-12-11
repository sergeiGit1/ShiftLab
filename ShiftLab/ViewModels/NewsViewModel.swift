//
//  NewsViewModel.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 11.12.2023.
//

import Foundation

class NewsViewModel {
    private let newsAPI = NewsAPI.shared
    var articles: [Article] = []
    var article = Dynamic("")

    func getData(completion: @escaping(Result<Void, NewsAPIError>) -> Void) {
        newsAPI.fetchData { [weak self] result in
            switch result {
            case .success(let fetchedArticles):
                self?.articles = fetchedArticles
                completion(.success(()))
            case .failure(let failure):
                print("\(failure)")
            }
        }
    }
}



