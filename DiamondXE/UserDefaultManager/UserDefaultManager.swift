//
//  UserDefaultManager.swift
//  DiamondXE
//
//  Created by iOS Developer on 28/05/24.
//

import Foundation


class UserDefaultManager {
   
    static let shareInstence = UserDefaultManager()
    
    func saveHomeData(homeObj: HomeDataStruct) {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(homeObj) {
            UserDefaults.standard.set(encodedUser, forKey: "homeData")
        }
    }
    
    func retrieveHomeData() -> HomeDataStruct? {
        if let savedUserData = UserDefaults.standard.data(forKey: "homeData") {
            let decoder = JSONDecoder()
            if let savedUser = try? decoder.decode(HomeDataStruct.self, from: savedUserData) {
                return savedUser
            }
        }
        return nil
    }
    
    func saveTopDeals(topDelsObj: TopDealsDataStruct) {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(topDelsObj) {
            UserDefaults.standard.set(encodedUser, forKey: "topDeals")
        }
    }
    
    func retrieveTopDeals() -> TopDealsDataStruct? {
        if let savedUserData = UserDefaults.standard.data(forKey: "topDeals") {
            let decoder = JSONDecoder()
            if let savedUser = try? decoder.decode(TopDealsDataStruct.self, from: savedUserData) {
                return savedUser
            }
        }
        return nil
    }
    
    
    func saveSearchFieldsData(topDelsObj: SearchOptionDataStruct) {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(topDelsObj) {
            UserDefaults.standard.set(encodedUser, forKey: "SearchOption")
        }
    }
    
    func retrieveSearchFieldsData() -> SearchOptionDataStruct? {
        if let savedUserData = UserDefaults.standard.data(forKey: "SearchOption") {
            let decoder = JSONDecoder()
            if let savedUser = try? decoder.decode(SearchOptionDataStruct.self, from: savedUserData) {
                return savedUser
            }
        }
        return nil
    }
    
    
    func saveLoginData(topDelsObj: LoginDataStruct) {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(topDelsObj) {
            UserDefaults.standard.set(encodedUser, forKey: "LoginData")
        }
    }
    
    func retrieveLoginData() -> LoginDataStruct? {
        if let savedUserData = UserDefaults.standard.data(forKey: "LoginData") {
            let decoder = JSONDecoder()
            if let savedUser = try? decoder.decode(LoginDataStruct.self, from: savedUserData) {
                return savedUser
            }
        }
        return nil
    }
    
    func clearAllUserDefaults() {
        let defaults = UserDefaults.standard
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: bundleIdentifier)
            defaults.synchronize()
        }
    }
    
    func clearLoginDataDefaults() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "LoginData")
    }
    
}


//SearchOptionDataStruct
