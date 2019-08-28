//
//  Game.swift
//  PickUp
//
//  Created by Anushrut Shah on 25/04/2019.
//  Copyright © 2019 Anushrut Shah. All rights reserved.
//

import Foundation
import Firebase

class Game {
    var gameNum: Int!
    var pitch: String!
    var numPlayers: Int!
    
    init(gameNum: Int, pitch: String, numPlayers: Int) {
        self.gameNum = gameNum
        self.pitch = pitch
        self.numPlayers = numPlayers
    }
}

class Games {
    
    static var gameCells = [Game]();
    static var ref: DatabaseReference! = Database.database().reference(withPath: "game")
    
    static func loadData() {
      //gameCells.removeAll()
        func pullGames(callback: @escaping (Game) -> ()) {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                // TIP: print snapshot here to see what the returned data looks like.
                //print(snapshot)
                for case let gameSnapshot as DataSnapshot in snapshot.children { // for each coffee_shops entry
                    //print ("THIS IS")
                    //print (cafeSnapshot)
                    //print (cafeSnapshot.key)
                    //print (cafeSnapshot.value!)*/
                    // TIP: print cafeSnapshot, cafeSnapshot.key, cafeSnapshot.value to see what a single child of snapshot looks like
                    
                    let value = gameSnapshot.value as? [String: Any]
                    let gameNo = gameCells.count + 1
                    let numPlayers = value?["numPlayers"] as? Int
                    let pitch = value?["pitch"] as? String
                    // TODO: construct Game objects from gameSnapshot, and pass them into callback
                    let game = Game(gameNum: gameNo, pitch: pitch!, numPlayers: numPlayers!)
                    //print(game)
                    updateData(g: game)
                    callback(game)
                }
            })
            //print("The array has")
            //print(cafes)
            }
        }
    static func updateData(g: Game) {
        gameCells.append(g);
    }
    
    static func LoopGames() {
        //print("HERE IS")
        //print(FirebaseDataManager.cafes.count)
        for game in gameCells {
            //print("I'm in the loop")
            updateData(g: game)
        }
    }
    
    static func totalPlayers(pitch: String) -> Int {
        var total: Int = 0
        for game in gameCells {
            if game.pitch == pitch {
                total = total + game.numPlayers
            }
        }
        return total
    }

}
