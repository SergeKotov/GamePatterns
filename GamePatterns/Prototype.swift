//
//  Prototype.swift
//  GamePatterns
//
//  Created by Serge Kotov on 14.10.2022.
//

import Foundation

// MARK: 'Prototype' Pattern

// a base abstract class
class Monster { }

// monster subclasses

class Ghost: Monster {
    var isScary: Bool
    
    init(isScary: Bool) {
        self.isScary = isScary
    }
}
class Vampire: Monster { }

class Zombie: Monster {
    var isDangerous: Bool
    
    init(isDangerous: Bool) {
        self.isDangerous = isDangerous
    }
}

class Spawner {
    typealias MonsterClone = () -> Monster
    
    var clone: MonsterClone
    
    init(clone: @escaping MonsterClone) {
        self.clone = clone
    }
}

// MARK: - Sample code

let prototypeExample = {
    print("\nPrototype")
    print("Specify the kinds of objects to create using a prototypical instance, and create new objects from the 'skeleton' of an existing object, thus boosting performance and keeping memory footprints to a minimum.\n")
    
    let ghostPrototype = { Ghost(isScary: true) }
    let zombiePrototype = { Zombie(isDangerous: false) }
    
    let monsterSpawner = Spawner(clone: ghostPrototype)
    
    if let ghost = monsterSpawner.clone() as? Ghost {
        print("\(type(of: ghost)) is scary: \(ghost.isScary)")
    }
      
    monsterSpawner.clone = { Zombie(isDangerous: false) }
    if let zombie = monsterSpawner.clone() as? Zombie {
        print("\(type(of: zombie)) is dangerous: \(zombie.isDangerous)")
    }
}
