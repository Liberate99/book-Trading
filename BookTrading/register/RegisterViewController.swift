//
//  RegisterViewController.swift
//  BookTrading
//
//  Created by apple on 2018/5/13.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var backToLoginButton: UIButton!
    
    @IBAction func registerAction(_ sender: Any) {
        print("注册")
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
