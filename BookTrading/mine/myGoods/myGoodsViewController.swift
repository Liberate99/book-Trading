//
//  myGoodsViewController.swift
//  BookTrading
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Book: NSObject {
    var bookname: String = ""
    var price: Float = 0
}

class myGoodsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var base: baseUserClass = baseUserClass()
    
    // dataSource
    var bookDataArray = [Book]()
    
    
    
    /**
     *  加载数据
     */
    @objc func getBooks(){
        bookDataArray = []
        // 获取bookDataArray数据
        let _parameter = ["promulgatorid" : self.base.cacheGetString(key: "userid")]
        Alamofire.request("http://127.0.0.1:8080/book/selectAllBooksByPromulgatorid?", method: .get, parameters: _parameter, encoding: URLEncoding.default)
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
                        
                        if dataDic["status"].int != 0 {
                            continue
                        }
                        let model = Book()
                        //  ??  NIL合并运算符，它的作用是如果 A 不是NIL 就返回前面可选类型参数 A 的确定值， 如果 A 是NIL 就返回后面 B 的值
                        model.bookname = dataDic["bookname"].string ?? ""
                        
                        model.price = dataDic["bookprice"].float ?? 0
                        
                        self.bookDataArray.append(model)
                    }
                    self.myGoodsTableview.reloadData()
                    //self.refreshAction.endRefreshing()
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let goodCell: goodsTableViewCell = self.myGoodsTableview.dequeueReusableCell(withIdentifier: "goodCell") as! goodsTableViewCell
        goodCell.bookname.text = bookDataArray[indexPath.row].bookname
        goodCell.price.text = "\(bookDataArray[indexPath.row].price)"
        return goodCell
    }
    

    @IBOutlet weak var myGoodsTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
        myGoodsTableview.dataSource = self
        
        self.navigationItem.title = "我的发布"
        let item = UIBarButtonItem(title: "我的", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        self.navigationController?.navigationBar.tintColor = UIColor.white

        
        // 注册cell
        let cellNib = UINib(nibName: "goodsTableViewCell", bundle: nil)
        myGoodsTableview.register(cellNib, forCellReuseIdentifier: "goodCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
