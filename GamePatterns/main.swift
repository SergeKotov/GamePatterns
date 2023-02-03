//
//  main.swift
//  GamePatterns
//
//  Created by Serge Kotov on 17.09.2022.
//

import Foundation

print("Enter a number to run a sample code for the pattern:")
print("1  Command")
print("2  Decorator")
print("3  Delegate")
print("4  Flyweight")
print("5  Game Loop")
print("6  Observer")
print("7  Prototype")
print("8  ServiceLocator")
print("9  Singleton")
print("> ", terminator: " ")

guard let num = Int(readLine() ?? "X") else {
    print("Press a correct number")
    exit(66)
}

switch num {
case 1: commandExample()
case 2: decoratorExample()
case 3: delegateExample()
case 4: flyweightExample()
case 5: gameLoopExample()
case 6: observerExample()
case 7: prototypeExample()
case 8: serviceLocatorExample()
case 9: singletonExample()
default:
    print("An incorrect number.")
}
