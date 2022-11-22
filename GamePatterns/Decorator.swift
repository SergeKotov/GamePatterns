//
//  Decorator.swift
//  GamePatterns
//
//  Created by Serge Kotov on 21.11.2022.
//

import Foundation

// MARK: 'Decorator' Pattern

// A service with extended responsibilities
struct LoggedScreen: ScreenRepresentable {
    
    var isPortrait: Bool {
        let mode = true
        print(" is portrait: \(mode)")
        return mode
    }
    
    var size: CGSize {
        willSet {
            print(" size: \(newValue)")
        }
    }
    
    var center: CGPoint {
        let point = CGPoint(x: size.width/2,
                            y: size.height/2)
        print(" center coordinate: \(point)")
        return point
    }
    
    var zpos: CGFloat {
        willSet {
            print(" z position: \(newValue)")
        }
    }
}

func enableLoggedScreen() {
    let logged = LoggedScreen(size: CGSize(width: 300, height: 600), zpos: 100)
    ScreenLocator.provide(current: logged)
}

// MARK: - Sample code

let decoratorExample = {
    print("\nDecorator")
    print("Attach additional responsibilities to an object dynamically keeping the same interface.\n")
    
    // create a default screen instance
    let defaultScreen = ScreenLocator.screen
    print(defaultScreen)
    
    // change the screen setting to new logged instance
    enableLoggedScreen()
    
    // check new responsibilities
    var screen = ScreenLocator.screen
    print("New screen settings:")
    let _ = screen.isPortrait
    screen.size = CGSize(width: 100, height: 200)
    let _ = screen.center
    screen.zpos = 120
        
    print()
}
