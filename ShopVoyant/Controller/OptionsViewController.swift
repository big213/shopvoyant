//
//  OptionsViewController.swift
//  ShopVoyant
//
//  Created by Mirana Abrar Anwar on 8/23/20.
//  Copyright © 2020 Mirana Anwar. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController{
    
        override func viewDidLoad() {
                super.viewDidLoad()
    //        tableView.dataSource = self

        }
    
    override func viewWillAppear(_ animated: Bool) {
    
    
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
}

override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
}

}
