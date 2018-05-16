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
    
    var bookId = 0
    
    @IBOutlet weak var promulgatorPicImage: UIImageView!
    @IBOutlet weak var promulgatorNameLabel: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var bookPicImage: UIImageView!
    @IBOutlet weak var bookPriceLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
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
                        self.promulgatorPicImage.image = UIImage(data: userPicData! as Data)
                    } else {
                        self.promulgatorPicImage.image = UIImage(named: "无法加载图片")
                        print("picture is nil! /n")
                    }
                    // 加载书籍图片
                    let bookPicURL = URL(string: JSOnDictory["picurl"].string!)
                    let bookPicData = NSData(contentsOf: bookPicURL!)
                    if bookPicData != nil {
                        self.bookPicImage.image = UIImage(data: bookPicData! as Data)
                    } else {
                        self.bookPicImage.image = UIImage(named: "无法加载图片")
                        print("picture is nil! /n")
                    }
                    // 加载书籍价格
                    self.bookPriceLabel.text = "\(JSOnDictory["bookprice"])"
                    // 加载书籍名称
                    self.bookNameLabel.text = "《\(JSOnDictory["bookname"].string!)》"
                    // 加载书籍发布者名称
                    self.promulgatorNameLabel.text = JSOnDictory["username"].string ?? ""
                    // 加载书籍发布时间
                    self.publishDate.text = JSOnDictory["publishtime"].string ?? ""
                    // 加载书籍内容简介
                    let nameString = JSOnDictory["bookcontent"].string ?? ""
                    let nameStr:NSMutableAttributedString = NSMutableAttributedString(string: nameString)
                    let style = NSMutableParagraphStyle()
                    style.lineSpacing = 8
                    nameStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSMakeRange(0, nameString.characters.count))

                    self.bookContentLabel.attributedText = nameStr
                }
        }
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
        //self.automaticallyAdjustsScrollViewInsets = true
        
        self.promulgatorPicImage.layer.cornerRadius = 25
        self.promulgatorPicImage.layer.masksToBounds = true
        
        self.bookContentLabel.numberOfLines = 0
        //self.bookContentLabel.text?.appending("\n\n\n\n\n")
        self.bookContentLabel.lineBreakMode = .byClipping
        

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
