//
//  Delegate.swift
//  GamePatterns
//
//  Created by Serge Kotov on 18.10.2022.
//

import Foundation

// MARK: 'Delegate' Pattern

// an interface to share behavior
protocol VoiceDelegate {
    func aah()
    func ouh()
}

// an implementation of the behavior
class GoblinShout: VoiceDelegate {
    func aah() {
        print("Aaaahhh")
    }
    
    func ouh() {
        print("Ooouuuuyhhh")
    }
}

// example of actors

struct Goblin: Decodable {
    let name: String
    let minHealth: Int
    let maxHealth: Int
    let resists: [String]
    let weaknesses: [String]
}

struct Wizard: Decodable {
    let name: String
    let prototype: String
    let spells: [String]
}

struct Archer: Decodable {
    let name: String
    let prototype: String
    let attacks: [String]
}

struct GoblinWizard {
    let name: String
    let prototype: Goblin
    let spells: [String]
    
    var voice: VoiceDelegate
}

struct GoblinArcher {
    let name: String
    let prototype: Goblin
    let attacks: [String]
    
    var voice: VoiceDelegate
}

// MARK: - Sample code

let delegateExample = {
    print("\nDelegate")
    print("Allows object composition to achieve the same code reuse as inheritance.\n")
    
    do {
        var jsonData = goblinJSON.data(using: .utf8)!
        let goblin: Goblin = try JSONDecoder().decode(Goblin.self, from: jsonData)
        
        jsonData = wizardJSON.data(using: .utf8)!
        let wizard: Wizard = try JSONDecoder().decode(Wizard.self, from: jsonData)
        
        jsonData = archerJSON.data(using: .utf8)!
        let archer: Archer = try JSONDecoder().decode(Archer.self, from: jsonData)
        
        let shout = GoblinShout()
        let goblinArcher = GoblinArcher(name: archer.name, prototype: goblin, attacks: archer.attacks, voice: shout)
        
        print("\(goblinArcher.name):", terminator: " ")
        goblinArcher.voice.aah()

    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
