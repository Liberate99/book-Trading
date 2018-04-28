//
//  LogInViewController.swift
//  BookTrading
//
//  Created by apple on 2018/4/28.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        self.present(TabBarViewController(), animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //收起键盘
        UsernameTextField.resignFirstResponder()
        //打印出文本框中的值
        print(UsernameTextField.text ?? "")
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UsernameTextField.clearButtonMode = .whileEditing  //编辑时出现清除按钮
//        UsernameTextField.clearButtonMode = .unlessEditing  //编辑时不出现，编辑后才出现清除按钮
        UsernameTextField.delegate = self
        PasswordTextField.delegate = self
        UsernameTextField.clearButtonMode = .always  //一直显示清除按钮
        
        PasswordTextField.clearButtonMode = .always
        
        PasswordTextField.isSecureTextEntry = true //输入内容会显示成小黑点
        
//        self.backgroundView.backgroundColor = UIColor.brown
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
