//
//  LogInViewController.swift
//  BookTrading
//
//  Created by apple on 2018/4/28.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

extension UITextField{
    //MARK:-设置暂位文字的颜色
    var placeholderColor:UIColor {
        get{
            let color =   self.value(forKeyPath: "_placeholderLabel.textColor")
            if(color == nil){
                return UIColor.white;
            }
            return color as! UIColor;
        }
        set{
            self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    //MARK:-设置暂位文字的字体
    var placeholderFont:UIFont{
        get{
            let font =   self.value(forKeyPath: "_placeholderLabel.font")
            if(font == nil){
                return UIFont.systemFont(ofSize: 14);
            }
            return font as! UIFont;
        }
        set{
            self.setValue(newValue, forKeyPath: "_placeholderLabel.font")
        }
    }
}

class LogInViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    // 登录
    @IBAction func loginButtonAction(_ sender: Any) {
        
        
        let paramerts = ["userid":1]
        Alamofire.request("http://localhost:8080/user/selectUserById?", method: .get, parameters: paramerts, encoding: URLEncoding.default)
            .validate()
            .response {response in
                print("Request: \(String(describing: response.request))")
                print("Response: \(response.response)")
                print("Error: \(response.error)")
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                }
            }
        self.present(TabBarViewController(), animated: true, completion: nil)
    }
    
    // 注册
    @IBAction func signInButtonAction(_ sender: Any) {
        self.present(RegisterViewController(), animated: true, completion: nil)
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
       
        // TextField Delegate
        UsernameTextField.delegate = self
        PasswordTextField.delegate = self
        
        // TextField Backgroundcolor
        UsernameTextField.backgroundColor = UIColor.black
        PasswordTextField.backgroundColor = UIColor.black
        
        // 边框圆角半径
        UsernameTextField.layer.cornerRadius = 5
        PasswordTextField.layer.cornerRadius = 5
        
        // 边框粗细
        UsernameTextField.layer.borderWidth = 1.0
        PasswordTextField.layer.borderWidth = 1.0
        
        // 边框颜色-白色
        UsernameTextField.layer.borderColor = UIColor.gray.cgColor
        PasswordTextField.layer.borderColor = UIColor.gray.cgColor

        // 文本框提示文字
        UsernameTextField.placeholder = "请输入用户名"
        PasswordTextField.placeholder = "请输入密码"
        
        // 文本框提示文字颜色
        UsernameTextField.placeholderColor = UIColor.gray
        PasswordTextField.placeholderColor = UIColor.gray
        
        // 文本框字体颜色
        UsernameTextField.textColor = UIColor.white
        PasswordTextField.textColor = UIColor.white

        // 一直显示清除按钮
        UsernameTextField.clearButtonMode = .always
        PasswordTextField.clearButtonMode = .always
        
        // 文本框键盘类型
        UsernameTextField.keyboardType = UIKeyboardType.emailAddress
        
        // 居中
        UsernameTextField.textAlignment = .center
        UsernameTextField.contentVerticalAlignment = .center
        PasswordTextField.textAlignment = .center
        PasswordTextField.contentVerticalAlignment = .center
        
        // 密码输入
        PasswordTextField.isSecureTextEntry = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
