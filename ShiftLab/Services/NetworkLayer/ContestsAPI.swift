//
//  KontestsAPI.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 10.12.2023.
//

import Foundation

//enum ContestsAPIError: Error {
//    case invalidURL
//    case dataTaskError(Error)
//    case noData
//    case decodingError(Error)
//}
//
//class ContestsAPI {
//    static let shared = ContestsAPI()
//    
//    private init() {}
//    
//    func fetchData(completion: @escaping (Result<Data, ContestsAPIError>) -> Void) {
//        guard let url = URL(string: <#T##String#>) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                completion(.failure(.dataTaskError(error)))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//            
//            completion(.success(data))
//        }
//        task.resume()
//    }
//}
