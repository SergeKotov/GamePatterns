//
//  Singleton.swift
//  GamePatterns
//
//  Created by Serge Kotov on 19.10.2022.
//

import Foundation

// MARK: 'Singleton' Pattern

class MemorySystem {
    
    // the global instance of the class
    static let shared = MemorySystem()

    // the private initializer to ensure the class has only one instance
    private init() {
        print("Singleton \(type(of: self)) created")
    }
    
    var lastSession: Date {
        get {
            UserDefaults.standard.object(forKey: "lastDate") as? Date ?? Date()
        }
        set {
            UserDefaults.standard.set(Date(), forKey: "lastDate")
        }
    }
    
    var nickname: String {
        get {
            UserDefaults.standard.string(forKey: "nickname") ?? "Anonymous"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
}

// MARK: - Sample code

let singletonExample = {
    print("\nSingleton pattern")
    print("Ensure a class has only one instance, and provide a global point of access to it.\n")
    
    let file = MemorySystem.shared
    
    print("player: \(file.nickname)")
    
    print("last session at: \(file.lastSession)")
    
    let date = Date()
    file.lastSession = date
    print("new session at: \(date)")
}
