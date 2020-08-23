//
//  LoginViewController.swift
//  ShopVoyant
//
//  Created by Mirana Abrar Anwar on 8/22/20.
//  Copyright © 2020 Mirana Anwar. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        // Use Firebase library to configure APIs
        if let email = emailText.text, let password = passwordText.text {
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            if let e = error{
                print(e)
            } else {
                self.performSegue(withIdentifier:"LoginToFind", sender: self)
            }
        }
        }
    }
}
