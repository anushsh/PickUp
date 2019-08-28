//
//  ViewController.swift
//  PickUp
//
//  Created by Anushrut Shah on 12/04/2019.
//  Copyright © 2019 Anushrut Shah. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func logIn(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: {(user, error) in
                if user != nil {
                    self.emailText.text = ""
                    self.passwordText.text = ""
                    self.performSegue(withIdentifier: "LoginSegue", sender: self)
                }
                else {
                    if let err = error?.localizedDescription {
                        print(err)
                    } else { print ("ERROR")}
                }
            })
        }
    }
    
    @IBAction func prepareForUnwind (segue: UIStoryboardSegue) {
        
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        let segue = UnwindSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }

}

