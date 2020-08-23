//
//  createShopViewController.swift
//  ShopVoyant
//
//  Created by Mirana Abrar Anwar on 8/22/20.
//  Copyright © 2020 Mirana Anwar. All rights reserved.
//

import UIKit
import Firebase

class CreateShopViewController: UIViewController {
    lazy var functions = Functions.functions()

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addressLine2TextField: UITextField!
    @IBOutlet weak var addressLine1TextField: UITextField!
    
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    
    @IBOutlet weak var countryTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createShopPressed(_ sender: UIButton) {
        guard let url = URL(string: "https://us-central1-shopvoyant-483f6.cloudfunctions.net/api/jql") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String:Any] = [
            "action": "addShop",
            "query": [
                "id": nil,
            "name": nil,
            "image": nil,
                ],
            "__args": [
                "name": nameTextField.text,
                "image": nil,
                "address_line_1": addressLine1TextField.text,
                "address_line_2": addressLine2TextField.text,
                "address_city": cityTextField.text,
                "address_state": stateTextField.text,
                "address_postal_code": postalCodeTextField.text,
                "address_country": countryTextField.text
            ]
        ]
                
        guard let httpBody = try? JSONSerialization.data(withJSONObject: json, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
        }.resume()
         //creating the pop up alert
         let alert = UIAlertController(title: "Create Your Shop", message: "Successfully added your shop!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            print("ok")
        }
        alert.addAction(action)
         present(alert, animated: true, completion: nil)
}

}

