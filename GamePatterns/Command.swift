//
//  Command.swift
//  GamePatterns
//
//  Created by Serge Kotov on 19.09.2022.
//

// MARK: 'Command' Pattern

// an actor
class GameActor {
    var position = Position(x: 0, y: 0)
        
    func jump() { print("make jump") }
    func fire() { print("just fire") }
    func moveTo(_ pos: Position) {
        position = pos
        print("Just moved to position: \(position)")
    }
}

// the command interface
protocol Commandable {
    func execute(_ actor: GameActor)
}

// command examples

struct JumpCommand: Commandable {
    func execute(_ actor: GameActor) {
        actor.jump()
    }
}

struct FireCommand: Commandable {
    func execute(_ actor: GameActor) {
        actor.fire()
    }
}

// the handling routine
struct InputHandler {
    var commands: [Button: Commandable]
    
    func getCommand(_ button: Button) -> Commandable? {
        commands[button]
    }
}

// MARK: - 'Command' Pattern with 'Undo'

protocol CommandableWithUndo {
    var unit: GameActor { get }
    
    mutating func execute()
    mutating func undo()
}

struct MoveCommand: CommandableWithUndo {
    let unit: GameActor
    
    var newPosition: Position?
    var positionBefore: Position?
    
    mutating func execute() {
        positionBefore = unit.position
        move()
    }
    
    mutating func undo() {
        swap(&newPosition, &positionBefore)
        move()
    }
    
    private func move() {
        if let pos = newPosition {
            unit.moveTo(pos)
        }
    }
}

struct СommandHandler {
    var unit: GameActor
    let actions: [Button: GameAction]
    var commandLog: [CommandableWithUndo] = []

    mutating func handleCommand(_ button: Button) {
        guard let action = actions[button] else { return }
        
        switch action {
        case .move(let direction):
            let dy = direction == .up ? 1 : -1 // use 'switch' for the full range
            let position = Position(x: unit.position.x, y: unit.position.y + dy)
            var command = MoveCommand(unit: unit, newPosition: position)
            command.execute()
            commandLog.append(command)
        case .undo:
            if !commandLog.isEmpty {
                var command = commandLog.removeLast()
                command.undo()
            }
        }
    }
}

// MARK: - Sample code

let commandExample = {
    print("\nCommand")
    print("Encapsulate a request as an object, thereby allowing for the parameterization of clients with different requests, and the queuing or logging of requests. It also allows for the support of undoable operations.\n")
    
    let actor = GameActor()
    var buttonPressed: Button
    
    print("\nSimple command actions")
    
    let inputHandler = InputHandler(commands: [.buttonX: JumpCommand(),
                                               .buttonY: FireCommand()])
    var command: Commandable?
    
    buttonPressed = .buttonX
    command = inputHandler.getCommand(buttonPressed)
    command?.execute(actor)
    
    buttonPressed = .buttonY
    command = inputHandler.getCommand(buttonPressed)
    command?.execute(actor)
    
    print("\nCommand actions with 'undo'")
    
    var commandHandler = СommandHandler(unit: actor,
                                        actions: [.buttonUp: .move(.up),
                                                  .buttonDown: .move(.down),
                                                  .controlZ: .undo])
    buttonPressed = .buttonUp
    commandHandler.handleCommand(buttonPressed)
    buttonPressed = .buttonUp
    commandHandler.handleCommand(buttonPressed)
    buttonPressed = .controlZ
    commandHandler.handleCommand(buttonPressed)
    commandHandler.handleCommand(buttonPressed)
    
    print()
}
