//
//  Contest.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 10.12.2023.
//

import Foundation

struct Contest: Decodable {
    var name: String
    var startTime: Date
    var endTime: Date
}
