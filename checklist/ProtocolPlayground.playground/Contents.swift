import UIKit

protocol Persist{
    func save()
}

class Monster: Persist{ //monster class implements the persist protocol
    func save(){
        print("Monster Save")
    }
}

class Sword: Persist{
    func save(){
        print("Sword Save")
    }
}

class Player{
    
}

let monster = Monster()
let sword = Sword()
let player = Player()

let items: [Persist] = [monster, sword]

class GameManager {
    func saveLevel(_ items : [Persist]){
        for item in items {
            item.save() //we can call save because that is in the protocol persist at the top[
        }
    }
}


let gameManager = GameManager()
gameManager.saveLevel(items)
