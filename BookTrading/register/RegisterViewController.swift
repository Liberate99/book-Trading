//
//  RegisterViewController.swift
//  BookTrading
//
//  Created by apple on 2018/5/13.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

//extension UITextField{
//    //MARK:-设置暂位文字的颜色
//    var placeholderColor:UIColor {
//        get{
//            let color =   self.value(forKeyPath: "_placeholderLabel.textColor")
//            if(color == nil){
//                return UIColor.white;
//            }
//            return color as! UIColor;
//        }
//        set{
//            self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
//        }
//    }
//    //MARK:-设置暂位文字的字体
//    var placeholderFont:UIFont{
//        get{
//            let font =   self.value(forKeyPath: "_placeholderLabel.font")
//            if(font == nil){
//                return UIFont.systemFont(ofSize: 14);
//            }
//            return font as! UIFont;
//        }
//        set{
//            self.setValue(newValue, forKeyPath: "_placeholderLabel.font")
//        }
//    }
//}

class RegisterViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password2: UITextField!
    
    
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var backToLoginButton: UIButton!
    
    @IBAction func registerAction(_ sender: Any) {
        print("注册")
        print(username.text)
        print(password.text)
        print(password2.text)
        
        if (username.text! != ""){
            if (password.text! != ""){
                if (password2.text! != ""){
                    if (password.text! == password2.text!){
                        let _parameter = ["username":username.text!] as [String : Any]
                        Alamofire.request("http://127.0.0.1:8080/user/selectUserByName?", method: .get, parameters: _parameter, encoding: URLEncoding.default)
                            .validate()
                            .responseJSON{
                                (response) in
                                // 有错误就打印错误，没有就解析数据
                                if let Error = response.result.error{
                                    print(Error)
                                } else if let jsonresult = response.result.value {
                                    // 用 SwiftyJSON 解析数据
                                    let data = JSON(jsonresult)
                                    print(data)
                                    if data == [] {
                                        print("账号可以写入数据库")
                                        self.addUser(username: self.username.text!, password: self.password.text!)
                                    }else{
                                        SwiftNotice.showText("该用户名已被占用！")
                                        print("用户名不可用")
                                    }
                                }
                        }
                    }else{ SwiftNotice.showText("密码不一致！")}
                }else{ SwiftNotice.showText("请确认密码！") }
            }else{ SwiftNotice.showText("请输入密码！") }
        }else{ SwiftNotice.showText("请输入用户名！") }
    }
    
    func addUser(username: String, password: String){
        print(username)
        print(password)
        let _parameter = ["username":username,"password": password] as [String : Any]
        
        Alamofire.request("http://127.0.0.1:8080/user/addUser?", method: .post, parameters: _parameter, encoding: URLEncoding.default)
            .validate()
            .responseJSON{
                (response) in
                // 有错误就打印错误，没有就解析数据
                if let Error = response.result.error{
                    print(Error)
                } else if let jsonresult = response.result.value {
                    // 用 SwiftyJSON 解析数据
                    let data = JSON(jsonresult)
                    print(data)
                    if data == 1 {
                        SwiftNotice.showText("注册成功！")
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        SwiftNotice.showText("注册失败！")
                    }
                }
            }
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //收起键盘
        username.resignFirstResponder()
        password.resignFirstResponder()
        password2.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // textfield delegate
        username.delegate = self
        password.delegate = self
        password2.delegate = self
        
        // textfield background
        username.backgroundColor = UIColor.black
        password.backgroundColor = UIColor.black
        password2.backgroundColor = UIColor.black
        
        // textfield 圆角半径
        username.layer.cornerRadius = 5
        password.layer.cornerRadius = 5
        password2.layer.cornerRadius = 5

        // textfield 边框粗细
        username.layer.borderWidth = 1.0
        password.layer.borderWidth = 1.0
        password2.layer.borderWidth = 1.0
        
        // textfield 边框颜色
        username.layer.borderColor = UIColor.gray.cgColor
        password.layer.borderColor = UIColor.gray.cgColor
        password2.layer.borderColor = UIColor.gray.cgColor

        // 文本框字体颜色
        username.textColor = UIColor.white
        password.textColor = UIColor.white
        password2.textColor = UIColor.white
        
        // 文本框提示文字
        username.placeholder = "请输入用户名"
        password.placeholder = "请输入密码"
        password2.placeholder = "请确认密码"
        
        // 文本框提示文字颜色
        username.placeholderColor = UIColor.gray
        password.placeholderColor = UIColor.gray
        password2.placeholderColor = UIColor.gray
        
        // 居中
        username.textAlignment = .center
        username.contentVerticalAlignment = .center
        password.textAlignment = .center
        password.contentVerticalAlignment = .center
        password2.textAlignment = .center
        password2.contentVerticalAlignment = .center
        
        // 密码输入
        password.isSecureTextEntry = true
        password2.isSecureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
