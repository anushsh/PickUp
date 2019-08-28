//
//  FirebaseDataManager.swift
//  PickUp
//
//  Created by Anushrut Shah on 25/04/2019.
//  Copyright © 2019 Anushrut Shah. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseDataManager {
    
    // Use these database references only. Please DO NOT create your own.
    private static let ref = Database.database().reference(withPath: "game")
    
    
    /*
     * Pulls all the cafés from the database
     */
    static var games = [Game?]()
    static func pullGames(callback: @escaping (Game) -> ()) {
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
                let gameNo = games.count + 1
                let numPlayers = value?["numPlayers"] as? Int
                let pitch = value?["pitch"] as? String
                // TODO: construct Cafe objects from cafeSnapshot, and pass them into callback
                let game = Game(gameNum: gameNo, pitch: pitch!, numPlayers: numPlayers!)
                //print(cafe)
                games.append(game)
                callback(game)
            }
        })
        //print("The array has")
        //print(cafes)
    }
}

