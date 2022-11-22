//
//  main.swift
//  GamePatterns
//
//  Created by Serge Kotov on 17.09.2022.
//

import Foundation

print("Press a number to run a sample code for the pattern:")
print("1  Command")
print("2  Decorator")
print("3  Delegate")
print("4  Flyweight")
print("5  Observer")
print("6  Prototype")
print("7  ServiceLocator")
print("8  Singleton")
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
case 5: observerExample()
case 6: prototypeExample()
case 7: serviceLocatorExample()
case 8: singletonExample()
default:
    print("An incorrect number.")
}
