//
//  Book.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 12.12.2023.
//

import Foundation

struct BookData: Decodable {
    let data: [Book]
}

struct Book: Decodable {
    let title: String
    let author: String
    let image: String
}
