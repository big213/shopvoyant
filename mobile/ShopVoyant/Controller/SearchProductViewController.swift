//
//  SearchProductViewController.swift
//  ShopVoyant
//
//  Created by Mirana Abrar Anwar on 8/23/20.
//  Copyright © 2020 Mirana Anwar. All rights reserved.
//


import UIKit
import Firebase
import SwiftyJSON
import Alamofire

class SearchProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
    @IBOutlet weak var nameTableView: UITableView!
    var productArray = [String]()
    var upcProductArray = [String]()
    @IBOutlet weak var searchProductText: UISearchBar!
    
    @IBOutlet weak var searchUPCText: UISearchBar!
    
    @IBOutlet weak var searchByUPC: UIButton!
    
    @IBOutlet weak var UPCtableView: UITableView!
    
    let URLstring = "https://us-central1-shopvoyant-483f6.cloudfunctions.net/api/jql"
    
    override func viewDidLoad() {
            super.viewDidLoad()
        nameTableView.dataSource = self
        UPCtableView.dataSource = self

    }
    
    
    @IBAction func searchButton(_ sender: UIBarButtonItem)  {
        guard let url = URL(string: "https://us-central1-shopvoyant-483f6.cloudfunctions.net/api/jql") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String:Any] = [
            "action": "getMultipleProduct",
            "query": [
                "data": [
                    "id": nil,
                    "name": nil,
                    "image": nil,
                    "upc": nil
                ],
                "__args": [
                    "search": searchProductText.text
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
            let productName = productJSON!["data"]["data"].arrayValue
            for product in productName {
                let name = product["name"].stringValue
//                print(productJSON)
                self.productArray.append(name)
//                print(self.productArray)
            }
            DispatchQueue.main.async {
                self.nameTableView.reloadData()
            }
            
        }.resume()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberRow = 1
        switch tableView {
        case nameTableView:
            numberRow = productArray.count
            case tableView:
                numberRow = upcProductArray.count
        default:
            print("somethings wrong")
        }
        return numberRow

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch tableView {
        case nameTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "SearchProduct", for: indexPath)
            cell.textLabel?.text = productArray[indexPath.row]
            case UPCtableView:
                cell = tableView.dequeueReusableCell(withIdentifier: "SearchUPCProduct", for: indexPath)
                cell.textLabel?.text = upcProductArray[indexPath.row]
                
        default:
            print("somethings wrong")

        }
        return cell

    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FindProduct", sender: self)
    }
    
    @IBAction func searchByUPC(_ sender: UIButton) {
        guard let url = URL(string: "https://us-central1-shopvoyant-483f6.cloudfunctions.net/api/jql") else { return }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let json: [String:Any] = [
                    "action": "getMultipleProduct",
                    "query": [
                        "data": [
                            "id": nil,
                            "name": nil,
                            "image": nil,
                            "upc": nil
                        ],
                        "__args": [
                            "upc": searchUPCText.text
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
                    let productName = productJSON!["data"]["data"].arrayValue
                    for product in productName {
                        let name = product["name"].stringValue
                        self.upcProductArray.append(name)
                        print(self.upcProductArray)
                    }
                    DispatchQueue.main.async {
                        self.UPCtableView.reloadData()
                    }

                }.resume()
        
    }

    
}

