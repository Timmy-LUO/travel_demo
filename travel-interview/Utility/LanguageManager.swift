//
//  LanguageManager.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/28.
//

import Foundation

public final class LanguageManager {
    
    public static let instance = LanguageManager()
    
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    public var languageCode: String? {
        get {
            return defaults.string(forKey: "languageCode")
        }
        set {
            defaults.setValue(newValue, forKey: "languageCode")
        }
    }
}
