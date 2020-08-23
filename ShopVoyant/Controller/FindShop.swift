//
//  FindShop.swift
//  ShopVoyant
//
//  Created by Mirana Abrar Anwar on 8/23/20.
//  Copyright © 2020 Mirana Anwar. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import Alamofire

class FindShopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var zipTableView: UITableView!
    @IBOutlet weak var zipCodeText: UITextField!
    var shopsArray = [String]()
    var shopAddress = [String]()
    override func viewDidLoad() {
            super.viewDidLoad()
        zipTableView.dataSource = self
    }
    
    
    @IBAction func searchBtnPressed(_ sender: UIBarButtonItem) {
        guard let url = URL(string: "https://us-central1-shopvoyant-483f6.cloudfunctions.net/api/jql") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String:Any] = [
            "action": "getProduct",
            "query": [
                "id": nil,
                "name": nil,
                "available_in": [
                    "data": [
                        "id": nil,
                        "quantity": nil,
                        "price": nil,
                        "shop": [
                            "id": nil,
                            "name": nil,
                            "image": nil,
                            "address_line_1": nil,
                            "address_line_2": nil,
                            "address_city": nil,
                            "address_state": nil,
                            "address_postal_code": nil,
                            "address_country": nil
                        ]
                    ],
                    "__args": [
                        "shop_zip": "10003",
                        "sortBy": ["price"],
                        "sortDesc": [false]
                    ]
                ],
                "__args": [
                    "id": 1
                ]
            ]
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: json, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)}
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            let productJSON = try? JSON(data: data!)
            let productName = productJSON!["data"]["available_in"]["data"].arrayValue
            for product in productName {
                let name = product["shop"]["name"].stringValue
                let address = product["shop"]["address_line_1"].stringValue
                print(address)
                self.shopsArray.append(name)
                self.shopAddress.append(address)
                //                print(self.productArray)
            }
                        DispatchQueue.main.async {
                            self.zipTableView.reloadData()
                        }
            
        }.resume()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopsArray.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ZipCell", for: indexPath)
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "ZipCell")

        cell.textLabel?.text = shopsArray[indexPath.row]
        cell.detailTextLabel?.text = shopAddress[indexPath.row
        ]
        return cell
        
    }
    
    
    }
 
