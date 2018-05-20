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
import SwiftyJSON

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
    
    var base: baseUserClass = baseUserClass()
    
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    // 登录
    @IBAction func loginButtonAction(_ sender: Any) {
        
//        var userName = ""
//        var passWord:Int? = nil
        
        print(UsernameTextField.text ?? "")
        print(PasswordTextField.text ?? "")
        
        if (UsernameTextField.text == "")||(PasswordTextField.text == "") {
            print("信息为空")
            SwiftNotice.showText("请输入用户名或密码")
        } else {
            let paramerts = ["username":UsernameTextField.text!]
            print(paramerts)
            Alamofire.request("http://127.0.0.1:8080/user/selectUserByName?", method: .get, parameters: paramerts, encoding: URLEncoding.default)
                .validate()
                .responseJSON {
                    (response) in
                    // 有错误就打印错误，没有就解析数据
                    if let Error = response.result.error{
                        print(Error)
                    } else if let jsonresult = response.result.value {
                        // 用 SwiftyJSON 解析数据
                        let data = JSON(jsonresult)
                        if data != [] {
                            if data.array![0]["password"].string != self.PasswordTextField.text!{
                                SwiftNotice.showText("密码错误")
                            } else {
                                
                                // 纪录用户名
                                self.base.cacheSetString(key: "userName", value: data.array![0]["username"].string!)
                                // 记录用户图片
                                self.base.cacheSetString(key: "userPic", value: data.array![0]["userpic"].string!)
//                                // 记录用户余额
//                                self.base.cacheSetFloat(key: "balance", value: data.array![0]["balance"].float!)
//                                print("\(data.array![0]["balance"].float)")
//                                print(self.base.cacheGetFloat(key: "balance"))
//                                print("=====================================================fine")
                                
                                let TabVC = TabBarViewController()
                                self.present(TabVC, animated: true, completion: nil)
                                
                            }
                        } else {
                            print("用户名或密码错误")
                            SwiftNotice.showText("用户名或密码错误")
                        }
                    }
                    
            }
            //self.present(TabBarViewController(), animated: true, completion: nil)
        }
    }
    
    // 注册
    @IBAction func signInButtonAction(_ sender: Any) {
        self.present(RegisterViewController(), animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //收起键盘
        UsernameTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
//        //打印出文本框中的值
//        print(UsernameTextField.text ?? "")
//        print(PasswordTextField.text ?? "")
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
