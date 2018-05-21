//
//  addBookViewController.swift
//  BookTrading
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class addBookViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "发布书籍"
        let item = UIBarButtonItem(title: "书市", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        self.navigationController?.navigationBar.tintColor = UIColor.white

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
