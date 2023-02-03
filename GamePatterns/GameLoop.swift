//
//  GameLoop.swift
//  GamePatterns
//
//  Created by Serge Kotov on 24.11.2022.
//

import Foundation

// MARK: Interactive terminal 'Game Loop' pattern

let terminalGameLoop = {
    
    var running = true
    
    func handleCommand(_ command: String) {
        if command == "exit" {
            running = false
        }
    }
    
    // running until 'exit' input
    while running {
        print("Enter a command:")
        let command = readLine() ?? "exit"
        handleCommand(command)
    }
    
    print("Goodbye")
}

// MARK: Fixed update time step, variable rendering game loop

let timeStepGameLoop = {
    
    let timeLag = 0.01667 // 60 FPS
    var running = true    
    var lastTime = Date()
    
    func update() {
        if chance(0.1) {
            running = false
        }
    }
    
    func render(_ dt: TimeInterval) {
        print(dt/timeLag)
    }
    
    func handleLoop(_ currentTime: Date) {
        var dt = currentTime.timeIntervalSince(lastTime)
        if dt >= timeLag {
            lastTime = currentTime
            
            while dt >= timeLag {
                update()
                dt -= timeLag
            }
        }
        render(dt)
    }
    
    // running until random close-event
    while running {
        handleLoop(Date())
    }
    
    print("Done")
}

// MARK: - Sample code

let gameLoopExample = {
    print("\nGame Loop")
    print("Decouple the progression of game time from user input and processor speed.\n")
    
    print("Interactive terminal game loop:")
    terminalGameLoop()
    
    print("Fixed update time step, variable rendering game loop:")
    timeStepGameLoop()
}
