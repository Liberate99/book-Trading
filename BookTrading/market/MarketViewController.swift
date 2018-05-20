//
//  MarketViewController.swift
//  BookTrading
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MarketViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
//    var base: baseUserClass = baseUserClass()
    
    // 数据源
    var bookWithPromulgatorDataArray = [bookWithPromulgator]()
    
    // tableView
    @IBOutlet weak var underTableView: UITableView!
    //    //设置单元格的大小
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 120
    //    }
    //    //设置不同种类的单元格的样式有多少
    //    override func numberOfSectionsInTableView(tableView:UITableView) ->Int{
    //    // #warning Potentially incomplete method implementation.
    //    // Return the number of sections.
    //    return 1
    //    }
    //组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     *  加载数据
     */
    func getBooks(){
        // 获取bookDataArray数据
        Alamofire.request("http://127.0.0.1:8080/book/selectAllBooksWithPromulgator", method: .get, parameters: nil, encoding: URLEncoding.default)
            .responseJSON {
                (response) in
                // 有错误就打印错误，没有就解析数据
                if let Error = response.result.error{
                    print(Error)
                } else if let jsonresult = response.result.value {
                    // 用 SwiftyJSON 解析数据
                    let JSOnDictory = JSON(jsonresult)
                    //let JSONDictory = jsonresult.data
                    let data = JSOnDictory.array
                    for dataDic in data!{
                        let model = bookWithPromulgator()
                        //  ??  NIL合并运算符，它的作用是如果 A 不是NIL 就返回前面可选类型参数 A 的确定值， 如果 A 是NIL 就返回后面 B 的值
                        model.bookId = dataDic["bookid"].int ?? 0
                        model.bookName = dataDic["bookname"].string ?? ""
                        model.autherName = dataDic["authername"].string ?? ""
                        model.picURL = dataDic["picurl"].string ?? ""
                        model.promulgatorId = dataDic["promulgatorid"].int ?? 0
                        model.purchaserId = dataDic["purchaserid"].int ?? 0
                        model.status = dataDic["status"].int ?? 0
                        model.bookPrice = dataDic["bookprice"].int ?? 0
                        model.bookContent = dataDic["bookcontent"].string ?? ""
                        model.publishDate = dataDic["publishtime"].string ?? ""
                        
                        model.userName = dataDic["username"].string ?? ""
                        model.userPic = dataDic["userpic"].string ?? ""
                        self.bookWithPromulgatorDataArray.append(model)
                    }
                    self.underTableView.reloadData()
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 状态栏白色
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.light)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]//NSAttributedStringKey
        underTableView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        getBooks()
        
        // 注册cell
        let cellNib = UINib(nibName: "MarketTableViewCell", bundle: nil)
        underTableView.register(cellNib, forCellReuseIdentifier: "cell")
        
    }
    
    // 继承tableviewdatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookWithPromulgatorDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MarketTableViewCell = self.underTableView.dequeueReusableCell(withIdentifier: "cell") as! MarketTableViewCell
        
        // 加载主题文本
        cell.cellTitleLabel.text = "《\(bookWithPromulgatorDataArray[indexPath.row].bookName)》有售"
        // 加载书籍图片
        let bookPicURL = URL(string: bookWithPromulgatorDataArray[indexPath.row].picURL)
        let bookPicData = NSData(contentsOf: bookPicURL!)
        if bookPicData != nil {
            cell.bookImageBackground.image = UIImage(data: bookPicData! as Data)
        } else {
            cell.bookImageBackground.image = UIImage(named: "无法加载图片")
            print("picture is nil! /n")
        }
        // 加载发布者图片
        let promulgatorPicURL = URL(string: bookWithPromulgatorDataArray[indexPath.row].userPic)
        let promulgatorPicData = NSData(contentsOf: promulgatorPicURL!)
        if promulgatorPicData != nil {
            cell.promulgatorImage.image = UIImage(data: promulgatorPicData! as Data)
        } else {
            cell.promulgatorImage.image = UIImage(named: "userPic")
            print("picture is nil! /n")
        }
        // 加载发布者姓名
        cell.promulgatorNameLabel.text = bookWithPromulgatorDataArray[indexPath.row].userName
        // 加载发布时间
        cell.publishDateLabel.text = "发布于 \(bookWithPromulgatorDataArray[indexPath.row].publishDate)"
        // 加载内容文本
        cell.cellContentLabel.text = bookWithPromulgatorDataArray[indexPath.row].bookContent
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let BWP = bookDetialViewController()
        BWP.bookId = bookWithPromulgatorDataArray[indexPath.row].bookId
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(BWP, animated: true)
        
        self.hidesBottomBarWhenPushed = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
