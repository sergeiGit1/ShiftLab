//
//  Contest.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 10.12.2023.
//

import Foundation

struct NewsResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    var author: String?
    var title: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case author
        case title
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
    }
    
    var formattedAuthor: String {
        return author ?? "Unknown Author"
    }
}

