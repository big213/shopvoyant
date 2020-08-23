//
//  RegisterViewController.swift
//  ShopVoyant
//
//  Created by Mirana Abrar Anwar on 8/22/20.
//  Copyright © 2020 Mirana Anwar. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
         Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
             if let e = error{
                 print(e.localizedDescription)
             } else{
                 // Navigate to the ChatViewController
                 self.performSegue(withIdentifier: "RegisterToFind", sender: self)
             }
         }
         }
        
    }

}
