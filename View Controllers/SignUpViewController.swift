//
//  SignUpViewController.swift
//  PickUp
//
//  Created by Anushrut Shah on 25/04/2019.
//  Copyright © 2019 Anushrut Shah. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    @IBAction func signUp(_ sender: UIButton) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!, completion: {(user, error) in
                if user != nil {
                    self.performSegue(withIdentifier: "SignUpSegue", sender: self)
                }
                else {
                    if let err = error?.localizedDescription {
                        print(err)
                    } else { print ("ERROR")}
                }
            })
        }
    }
    
    func showSecondViewController() {
        self.performSegue(withIdentifier: "swipeDown", sender: self)
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
