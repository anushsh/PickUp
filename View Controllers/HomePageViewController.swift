//
//  HomePageViewController.swift
//  PickUp
//
//  Created by Anushrut Shah on 25/04/2019.
//  Copyright © 2019 Anushrut Shah. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomePageViewController: UIViewController {
    var username: String = ""
    
    @IBOutlet weak var aceLabel: UILabel!
    @IBOutlet weak var dunningLabel: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var acePitch: UIImageView!
    @IBOutlet weak var dunningPitch: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = "Welcome " + username
        // Do any additional setup after loading the view.
    }
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "LogoutSegue", sender: self)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let acePeople = Games.totalPlayers(pitch: "AA")
        let dunningPeople = Games.totalPlayers(pitch: "DC")
        if (acePeople > 40) {
            aceLabel.text = "Ace Adams: Busy"
            acePitch.image = UIImage(named: "busy")
        } else if (acePeople > 20) {
            aceLabel.text = "Ace Adams: Moderate"
            acePitch.image = UIImage(named: "moderate")
        } else {
            aceLabel.text = "Ace Adams: Empty"
            acePitch.image = UIImage(named: "topPitch")
        }
        
        if (dunningPeople > 40) {
            dunningLabel.text = "Dunning-Cohen: Busy"
            dunningPitch.image = UIImage(named: "busy")
        } else if (dunningPeople > 20) {
            dunningLabel.text = "Dunning-Cohen: Moderate"
            dunningPitch.image = UIImage(named: "moderate")
        } else {
            dunningLabel.text = "Dunning-Cohen: Empty"
            dunningPitch.image = UIImage(named: "bottomPitch")
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
