//
//  CreateProductViewController.swift
//  ShopVoyant
//
//  Created by Mirana Abrar Anwar on 8/23/20.
//  Copyright © 2020 Mirana Anwar. All rights reserved.
//


import UIKit
import Firebase

class CreateProductViewController: UIViewController {

    @IBOutlet weak var upcTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var shopTextField: UITextField!
    
    @IBOutlet weak var quantityTextField: UITextField!
    
    @IBOutlet weak var productIdText: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
}

    @IBAction func addProductPressed(_ sender: UIBarButtonItem) {
                
        guard let url = URL(string: "https://us-central1-shopvoyant-483f6.cloudfunctions.net/api/jql") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String:Any] = [
            "action": "addProduct",
            "query": [
                "id": nil,
                "upc": nil,
                "name": nil,
                "image": nil,
                "__args": [
                    "name": nameTextField.text,
                    "upc": upcTextField.text,
                    "image": nil
                ]
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
         let alert = UIAlertController(title: "Add Product", message: "Successfully added your product!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            print("ok")
        }
        alert.addAction(action)
         present(alert, animated: true, completion: nil)
    }

    @IBAction func addAvailabilityPressed(_ sender: UIButton) {
        guard let url = URL(string: "https://us-central1-shopvoyant-483f6.cloudfunctions.net/api/jql") else { return }
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.addValue("application/json", forHTTPHeaderField: "Content-Type")
          
          let json: [String:Any] = [
              "action": "upsertProductShopInventoryLink",
              "query": [
                  "id": nil,
                  "__args": [
                    "product": productIdText.text,
                      "shop": shopTextField.text,
                      "quantity": quantityTextField.text,
                      "price": priceTextField.text
                  ]
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
          let alert = UIAlertController(title: "Add Availability Information", message: "Successfully claimed availability of product!", preferredStyle: .alert)
         let action = UIAlertAction(title: "Ok", style: .default) { (action) in
             print("ok")
         }
         alert.addAction(action)
          present(alert, animated: true, completion: nil)
    }
    
}
