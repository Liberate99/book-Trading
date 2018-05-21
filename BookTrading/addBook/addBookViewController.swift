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

class addBookViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var base: baseUserClass = baseUserClass()
    
    @IBOutlet weak var bookName: UITextField!
    @IBOutlet weak var bookAuther: UITextField!
    @IBOutlet weak var bookPrice: UITextField!
    @IBOutlet weak var bookContent: UITextView!
    @IBOutlet weak var bookPicURL: UITextView!
    @IBOutlet weak var ok: UIButton!
    
    func getDay() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
//        // 设置地域
//        dateFormatter.locale = Locale(identifier: "zh_CN")
        // 设置格式
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let str = dateFormatter.string(from: currentDate)
        print(str)
        return str
    }
    
    @IBAction func add(_ sender: Any) {
        print(bookName.text!)
        print(bookAuther.text!)
        print(bookPrice.text!)
        print(bookContent.text!)
        print(bookPicURL.text!)
        
        let _parameter = [  "bookname"      : bookName.text!,
                            "authername"    : bookAuther.text!,
                            "promulgatorid" : self.base.cacheGetString(key: "userid"),
                            "purchaserid"   : 0,
                            "status"        : 0,
                            "bookprice"     : bookPrice.text!,
                            "bookcontent"   : bookContent.text!,
                            "publishtime"   : getDay(),
                            "picurl"        : bookPicURL.text!] as [String : Any]

        Alamofire.request("http://127.0.0.1:8080/book/addBook?", method: .post, parameters: _parameter, encoding: URLEncoding.default)
            .validate()
            .responseJSON{
                (response) in
                // 有错误就打印错误，没有就解析数据
                if let Error = response.result.error{
                    print(Error)
                    SwiftNotice.showText("发布成功")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("添加成功")
                    SwiftNotice.showText("发布成功")
                    self.navigationController?.popViewController(animated: true)
                }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 收起键盘
        bookName.resignFirstResponder()
        bookAuther.resignFirstResponder()
        bookPrice.resignFirstResponder()
        bookContent.resignFirstResponder()
        bookPicURL.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDay()
        
        self.navigationItem.title = "发布书籍"
        let item = UIBarButtonItem(title: "书市", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.bookName.delegate = self
        self.bookAuther.delegate = self
        self.bookPrice.delegate = self
        self.bookContent.delegate = self
        self.bookPicURL.delegate = self
        
        // bookContent
        bookContent.layer.borderColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 0.15).cgColor
        bookContent.layer.borderWidth = 1
        bookContent.layer.cornerRadius = 5
        
        // bookPicURL
        bookPicURL.layer.borderColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 0.15).cgColor
        bookPicURL.layer.borderWidth = 1
        bookPicURL.layer.cornerRadius = 5
        
        // ok
        ok.layer.borderColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 0.15).cgColor
        ok.layer.borderWidth = 1
        ok.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
