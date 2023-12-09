//
//  User.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 09.12.2023.
//

import Foundation

struct UserData: Decodable, Encodable {
    let name: String?
    let surname: String?
    let dateOfBirth: String?
    let password: String?
}
