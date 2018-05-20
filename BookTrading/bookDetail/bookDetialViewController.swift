//
//  bookDetialViewController.swift
//  BookTrading
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class bookDetialViewController: UIViewController {
    
    // 由上个页面传值过来
    var bookId = 0
    
    var presentBalance = 0
    
    var purchasingBookWithPro: bookWithPromulgator = bookWithPromulgator()
    
    var base: baseUserClass = baseUserClass()
    
    @IBOutlet weak var promulgatorPicImage: UIImageView!
    @IBOutlet weak var promulgatorNameLabel: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var bookPicImage: UIImageView!
    @IBOutlet weak var bookPriceLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var exchangeButton: UIButton!
    @IBOutlet weak var collectButton: UIButton!
    @IBOutlet weak var bookContentLabel: UILabel!
    
    /**
     *  加载数据
     */
    func getBooks(bookid: Int){
        let parameter = ["bookid" : bookid]
        // 获取bookDataArray数据
        Alamofire.request("http://127.0.0.1:8080/book/selectAllBooksWithPromulgatorByBookId", method: .get, parameters: parameter, encoding: URLEncoding.default)
            .responseJSON {
                (response) in
                // 有错误就打印错误，没有就解析数据
                if let Error = response.result.error{
                    print(Error)
                } else if let jsonresult = response.result.value {
                    // 用 SwiftyJSON 解析数据
                    let JSOnDictory = JSON(jsonresult)
                    
                    // 数据填充
                    // 加载用户图片
                    let userPicURL = URL(string: JSOnDictory["userpic"].string!)
                    let userPicData = NSData(contentsOf: userPicURL!)
                    if userPicData != nil {
                        self.purchasingBookWithPro.userPic = JSOnDictory["userpic"].string!
                        self.promulgatorPicImage.image = UIImage(data: userPicData! as Data)
                    } else {
                        self.promulgatorPicImage.image = UIImage(named: "无法加载图片")
                        print("picture is nil! /n")
                    }
                    // 加载书籍图片
                    self.purchasingBookWithPro.picURL = JSOnDictory["picurl"].string!
                    let bookPicURL = URL(string: JSOnDictory["picurl"].string!)
                    let bookPicData = NSData(contentsOf: bookPicURL!)
                    if bookPicData != nil {
                        self.bookPicImage.image = UIImage(data: bookPicData! as Data)
                    } else {
                        self.bookPicImage.image = UIImage(named: "无法加载图片")
                        print("picture is nil! /n")
                    }
                    // 加载书籍价格
                    self.purchasingBookWithPro.bookPrice = JSOnDictory["bookprice"].int!
                    self.bookPriceLabel.text = "\(JSOnDictory["bookprice"])"
                    // 加载书籍名称
                    self.purchasingBookWithPro.bookName = JSOnDictory["bookname"].string!
                    self.bookNameLabel.text = "《\(JSOnDictory["bookname"].string!)》"
                    // 加载书籍发布者名称
                    self.purchasingBookWithPro.userName = JSOnDictory["username"].string!
                    self.promulgatorNameLabel.text = JSOnDictory["username"].string!
                    // 加载书籍发布时间
                    self.purchasingBookWithPro.publishDate = JSOnDictory["publishtime"].string!
                    self.publishDate.text = JSOnDictory["publishtime"].string!
                    // 加载书籍内容简介
                    self.purchasingBookWithPro.bookContent = JSOnDictory["bookcontent"].string!
                    let nameString = JSOnDictory["bookcontent"].string!
                    let nameStr:NSMutableAttributedString = NSMutableAttributedString(string: nameString)
                    let style = NSMutableParagraphStyle()
                    style.lineSpacing = 8
                    nameStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSMakeRange(0, nameString.characters.count))
                    self.bookContentLabel.attributedText = nameStr
                }
        }
    }
    
    // 交换
    @IBAction func exchange(_ sender: Any) {

        // TODO 查询适合交换的书（自己书的价格《= 要换书的价格》）
        // TODO 选择自己用来交换的书
        // TODO 实现交换
        let EVW = exchangeViewController()
        //EVW.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        EVW.userid = self.base.cacheGetString(key: "userid")
        EVW.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(EVW, animated: true, completion: nil)
        
    }
    
    // 直接购买
    @IBAction func purchase(_ sender: Any) {
        let purchaseAlert = UIAlertController(title: "购买", message: "确认要用\(self.bookPriceLabel.text!)购买\(self.bookNameLabel.text!)吗?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            print("点击了确定")
            // 获取用户余额
            let parameter1 = ["username": self.base.cacheGetString(key: "username")]
            Alamofire.request("http://127.0.0.1:8080/user/selectUserBalanceByName?", method: .get, parameters: parameter1, encoding: URLEncoding.default)
                .validate()
                .responseJSON{
                    (response) in
                    // 有错误就打印错误，没有就解析数据
                    if let Error = response.result.error{
                        print(Error)
                    } else if let jsonresult = response.result.value {
                        // 用 SwiftyJSON 解析数据
                        let data = JSON(jsonresult)
                        if data != [] {
                            self.presentBalance = data.int!
                            // 更新 user --balance 余额
                            self.upDateBalance(balance: Float(self.presentBalance), price: Float(self.purchasingBookWithPro.bookPrice), username: self.base.cacheGetString(key: "username"))
                            // 更新 book --status=1（状态） --puchaserid（购买者）
                            self.upDateStatus_PurchaserId(bookid: self.bookId, purchaserid: Int(self.base.cacheGetString(key: "userid"))!, status: 1)
                        } else {
                            print("???????????????????")
                        }
                    }
                }
        })
        purchaseAlert.addAction(okAction)
        purchaseAlert.addAction(cancelAction)
        self.present(purchaseAlert, animated: true, completion: nil)
        print("购买\(bookId)")
    }
    
    // 更新 book--status、purchaserid
    func upDateStatus_PurchaserId(bookid: Int,purchaserid: Int,status: Int){
        let _parameter = ["bookid": bookid,"purchaserid": purchaserid, "status": status] as [String : Any]
        Alamofire.request("http://127.0.0.1:8080/book/upDateBookStatusANDPurchaserId?", method: .post, parameters: _parameter, encoding: URLEncoding.default)
            .validate()
            .responseJSON{
                (response) in
                // 有错误就打印错误，没有就解析数据
                if let Error = response.result.error{
                    print(Error)
                } else if let jsonresult = response.result.value {
                    // 用 SwiftyJSON 解析数据
                    let data = JSON(jsonresult)
                    if data != [] {
                        if data == 1 { print("更新成功！\(data)") }
                        else { print("更新失败") }
                    }
                }
            }
    }
    
    // 更新 user--balance
    func upDateBalance(balance: Float,price: Float,username: String){
        let _parameter = ["username": username,"balance":balance-price] as [String : Any]
        Alamofire.request("http://127.0.0.1:8080/user/updateUserBalance?", method: .post, parameters: _parameter, encoding: URLEncoding.default)
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
                        if data == 1 { print("更新成功！\(data)") }
                        else { print("更新失败") }
                    }
                }
            }
    }
    
    @IBAction func collect(_ sender: Any) {
        
        // 显示提示  http://www.hangge.com/blog/cache/detail_2033.html
        SwiftNotice.showText("收藏！！！！")
        
        print("收藏\(bookId)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 请求参数 并填充
        getBooks(bookid: bookId)
        
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        let item = UIBarButtonItem(title: "书市", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.tabBarController?.hidesBottomBarWhenPushed = true
        self.tabBarController?.tabBar.isHidden = true
        
        self.promulgatorPicImage.layer.cornerRadius = 25
        self.promulgatorPicImage.layer.masksToBounds = true
        
        self.bookContentLabel.numberOfLines = 0
        self.bookContentLabel.lineBreakMode = .byClipping
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
