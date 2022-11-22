//
//  Observer.swift
//  GamePatterns
//
//  Created by Serge Kotov on 12.10.2022.
//

import Foundation
import Combine

// MARK: 'Observer' Pattern

class Achievements {
    
    private var cancellable: AnyCancellable?
    
    init(manager: Subject) {
        cancellable = manager.$achievement.sink { [weak self] achievement in
            if let achievement {
                self?.handle(achievement)
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func handle(_ achievement: Achievement) { }
}

// observers

class ScoreAchievements: Achievements {
    
    override func handle(_ achievement: Achievement) {
        switch achievement {
        case .bestScore(let score):
            print("New best score: \(score)!")
        default:
            break
        }
    }
}

class GameCenterAchievements: Achievements {
    
    var nonPrized = true
    
    override func handle(_ achievement: Achievement) {
        switch achievement {
        case .bestScore(let score):
            print("Send to Game Center new best score: \(score)")
        case .prize(let prize):
            if nonPrized {
                nonPrized = false
                print("Send to Game Center that a new prize is received: \(prize)!")
            }
        }
    }
}

// a subject
class Subject: ObservableObject {

    static let shared = Subject()

    private init() { }
    
    @Published private(set) var achievement: Achievement?
    
    func notify(achievement: Achievement) {
        self.achievement = achievement
    }
}

class GameEngine {
    
    var bestScore = 0
    
    func updatePhysics(for entity: Entity) {
        if entity.rewarded {
            Subject.shared.notify(achievement: .prize("Ruby"))
        }
        
        if entity.score > bestScore {
            bestScore = entity.score
            Subject.shared.notify(achievement: .bestScore(bestScore))
        }
    }
}

// MARK: - Sample code

let observerExample = {
    print("\nObserver")
    print("Define a one-to-many dependency between objects where a state change in one object results in all its dependents being notified and updated automatically.\n")
    
    var entity = Entity(name: "Prince")
    let engine = GameEngine()
    let scoring = ScoreAchievements(manager: Subject.shared)
    let gameCenter = GameCenterAchievements(manager: Subject.shared)
    
    entity.rewarded = true
    entity.score = 11
    engine.updatePhysics(for: entity)
    entity.score = 16
    engine.updatePhysics(for: entity)
}
