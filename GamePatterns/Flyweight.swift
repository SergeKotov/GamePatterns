//
//  Flyweight.swift
//  GamePatterns
//
//  Created by Serge Kotov on 22.09.2022.
//

import SpriteKit

// MARK: 'Flyweight' Pattern

class Terrain {
    let name: String
    let moveCost: Int
    let isWater: Bool
    let texture: SKTexture
    
    init(name: String, moveCost: Int, isWater: Bool, texture: SKTexture) {
        self.name = name
        self.moveCost = moveCost
        self.isWater = isWater
        self.texture = texture
    }
}

struct World {
    var tileCount: Int { tiles.count }
    
    init(tileCount: Int) {
        generateTerrain(tileCount: tileCount)
    }
    
    mutating func generateTerrain(tileCount: Int) {
        guard tileCount > 0 else { return }
        
        tiles.reserveCapacity(tileCount)
        for _ in 0..<tileCount {
            switch Float.random(in: 0...1) {
            case 0...0.5: tiles.append(grassTerrain)
            case 0.5...0.9: tiles.append(hillTerrain)
            default:
                tiles.append(riverTerrain)
            }
        }
    }
    
    func getTile(_ index: Int) throws -> Terrain {
        guard !tiles.isEmpty, (0..<tiles.count).contains(index) else {
            throw GameError.indexOutOfRange
        }
        
        return tiles[index]
    }
    
    private var tiles: [Terrain] = []
    
    // classes to clone references
    
    private let grassTerrain = Terrain(name: "Grass", moveCost: 1, isWater: false, texture: SKTexture())
    private let hillTerrain = Terrain(name: "Hill", moveCost: 3, isWater: false, texture: SKTexture())
    private let riverTerrain = Terrain(name: "River", moveCost: 2, isWater: true, texture: SKTexture())
}

// MARK: - Sample code

let flyweightExample = {
    print("\nFlyweight")
    print("Use sharing to support large numbers of similar objects efficiently.\n")
    
    var world = World(tileCount: 3000)
    
    for i in 1...6 {
        let ind = Int.random(in: (0...world.tileCount))
        if let tile = try? world.getTile(ind) {
            print("Terrain by tile \(ind): \(tile.name), move cost: \(tile.moveCost), water: \(tile.isWater)")
        }
    }
    
    print()
}
