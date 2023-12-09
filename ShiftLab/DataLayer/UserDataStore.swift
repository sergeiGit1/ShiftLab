//
//  UserDataStore.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 10.12.2023.
//

import Foundation

protocol UserDataStoreProtocol {
    func saveUserData(user: UserData)
    func loadUserData() -> UserData?
}

class UserDataStore: UserDataStoreProtocol {
    private let userDefaults = UserDefaults.standard
    private let userDataKey = "userDataKey"
    
    func saveUserData(user: UserData) {
        do {
            let userData = try JSONEncoder().encode(user)
            userDefaults.setValue(userData, forKey: userDataKey)
        } catch {
            print("Failed to encode user data: \(error.localizedDescription)")
        }
    }
    
    func loadUserData() -> UserData? {
        guard let userData = userDefaults.data(forKey: userDataKey) else { return nil }
        
        do {
            let user = try JSONDecoder().decode(UserData.self, from: userData)
            return user
        } catch {
            print("Failed to decode user data: \(error.localizedDescription)")
            return nil
        }
    }
    
}
