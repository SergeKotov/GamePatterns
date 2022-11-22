//
//  JsonData.swift
//  GamePatterns
//
//  Created by Serge Kotov on 18.10.2022.
//


let goblinJSON = """
{
  "name": "goblin grunt",
  "minHealth": 20,
  "maxHealth": 30,
  "resists": ["cold", "poison"],
  "weaknesses": ["fire", "light"]
}
"""

let wizardJSON = """
{
  "name": "goblin wizard",
  "prototype": "goblin grunt",
  "spells": ["fire ball", "lightning bolt"]
}
"""

let archerJSON = """
{
  "name": "goblin archer",
  "prototype": "goblin grunt",
  "attacks": ["short bow"]
}
"""
