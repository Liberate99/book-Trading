//
//  bookDetialViewController.swift
//  BookTrading
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class bookDetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var str = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.hidesBottomBarWhenPushed = true
        self.tabBarController?.tabBar.isHidden = true
        //self.automaticallyAdjustsScrollViewInsets = true
        label.text = str
        
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        let item = UIBarButtonItem(title: "书市", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
