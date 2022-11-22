//
//  ServiceLocator.swift
//  GamePatterns
//
//  Created by Serge Kotov on 21.11.2022.
//

import Foundation

// MARK: 'Service Locator' Pattern

// The interface
protocol ScreenRepresentable {
    var isPortrait: Bool { get }
    var size: CGSize { get set }
    var center: CGPoint { get }
    var zpos: CGFloat { get set }
}

// The service provider
struct Screen: ScreenRepresentable {
    var isPortrait: Bool { true }
    var size: CGSize
    var center: CGPoint { CGPoint(x: size.width/2,
                                  y: size.height/2) }
    var zpos: CGFloat
}

// The “null” service provider
struct DefaultScreen: ScreenRepresentable {
    var isPortrait: Bool { true }
    var size = CGSize.zero
    var center: CGPoint { .zero }
    var zpos = CGFloat.zero
}

// The service locator
class ScreenLocator {
    static var screen: ScreenRepresentable = DefaultScreen()
    
    static func provide(current: ScreenRepresentable) {
        screen = current
    }
}

// MARK: - Sample code

let serviceLocatorExample = {
    print("\nServiceLocator")
    print("Provide a global point of access to a service without coupling users to the concrete class that implements it.\n")
    
    // create a default screen instance
    let defaultScreen = ScreenLocator.screen
    print(defaultScreen)
    
    // set the standard screen for the locator service
    let standard = Screen(size: CGSize(width: 300, height: 600), zpos: 100)
    ScreenLocator.provide(current: standard)
    
    // create the standard screen instance
    let currentScreen = ScreenLocator.screen
    print(currentScreen)
    
    print()
}
