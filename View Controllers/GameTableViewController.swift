//
//  GameTableViewController.swift
//  PickUp
//
//  Created by Anushrut Shah on 25/04/2019.
//  Copyright © 2019 Anushrut Shah. All rights reserved.
//

import UIKit
import Firebase

class GameTableViewController: UITableViewController, GameCellDelegate {
    var ref: DatabaseReference! = Database.database().reference()
    var joining: Bool = true;
    func didTapJoin(game: Game) {
        let gNum = game.gameNum!
        if joining{
        game.numPlayers = game.numPlayers + 1
            ref.child("game/\(String(describing: gNum))/numPlayers").setValue(game.numPlayers)
            joining = false
            print(joining)
        }
        else {
            game.numPlayers = game.numPlayers - 1
            ref.child("game/\(String(describing: gNum))/numPlayers").setValue(game.numPlayers)
            joining = true
            print(joining)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.ref.child("game")
        Games.loadData()
    }
    @IBAction func createGame(_ sender: Any) {
        let alert = UIAlertController(title: "Message", message: "Create a Game!", preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Submit", style: .default) { (alertAction) in
            
            //what to do when submit is called
            let data = alert.textFields![0] as UITextField;
            let number = alert.textFields![1] as UITextField;
            if (data.text == "" || number.text == "" || Int(number.text!)! < 1 || (data.text != "AA" && data.text != "DC")){
                let alert2 = UIAlertController(title: "Error", message: "Please fill in text fields correctly!", preferredStyle: UIAlertController.Style.alert)
                alert2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in } ))
                self.present(alert2, animated: true, completion: nil)
            }
            else {
                let gameData = Game(gameNum: Games.gameCells.count + 1, pitch: data.text!, numPlayers: Int(number.text!)!)
                Games.updateData(g: gameData)
                self.ref.child("game/\(String(describing: Games.gameCells.count))").setValue(["numPlayers":number.text!, "pitch": data.text!])
                self.tableView.reloadData();
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Which pitch - AA or DC?"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "How many players?"
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in } ))
        self.present(alert, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Games.gameCells.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 106.0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gamesTheory")
        
        if let gameFeedCell = cell as? GameTableViewCell {
            let r = 0.0;
            let g = Double.random(in: 70 ..< 155);
            let b = Double.random(in: 128 ..< 256);
            gameFeedCell.backgroundColor = UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1);
            gameFeedCell.delegate = self
            let game = Games.gameCells[indexPath.row]
            gameFeedCell.game = game
            gameFeedCell.gameText.text = String(game.gameNum)
            gameFeedCell.pitchText.text = game.pitch
            gameFeedCell.playerCount.text = String (game.numPlayers);
            return gameFeedCell;
        } else {
            return UITableViewCell()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
