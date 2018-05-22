//
//  myCollectionViewController.swift
//  BookTrading
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class myCollectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let base: baseUserClass = baseUserClass()
    
    var collectionArray = [""]
    
    var refreshAction = UIRefreshControl.init()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let collectionCell: myCollectionTableViewCell = self.collectionTableView.dequeueReusableCell(withIdentifier: "myCollection") as! myCollectionTableViewCell
        let _parameter = ["bookid" : collectionArray[indexPath.row]]
        print(collectionArray)
        print(_parameter)
        Alamofire.request("http://127.0.0.1:8080/book/selectBookById?", method: .get, parameters: _parameter, encoding: URLEncoding.default)
            .validate(statusCode: 200..<600)
            .responseJSON{
                
                    (response) in
                    // 有错误就打印错误，没有就解析数据
                    if let Error = response.result.error{
                        print(Error)
                    } else if let jsonresult = response.result.value {
                        // 用 SwiftyJSON 解析数据
                        let data = JSON(jsonresult)
                        if data != [] {
                            print(data)
                            collectionCell.bookname.text = data["bookname"].string!
                            collectionCell.bookauther.text = data["authername"].string!
                        }
                    }
                
            }
        
//        collectionCell.bookname.text = bo
        return collectionCell
    }
    
    // getCollection
    @objc func getCollection(){
        let str: String = self.base.cacheGetString(key: "username")
        let _parameter = ["username":str] as [String : Any]
        Alamofire.request("http://127.0.0.1:8080/user/selectUserByName?", method: .get, parameters: _parameter, encoding: URLEncoding.default)
            .validate(statusCode: 200..<600)
            .responseJSON{
                (response) in
                // 有错误就打印错误，没有就解析数据
                if let Error = response.result.error{
                    print(Error)
                } else if let jsonresult = response.result.value {
                    // 用 SwiftyJSON 解析数据
                    let data = JSON(jsonresult)
                    if data != [] {
                        let collectionStr:NSString = data[0]["collection"].string! as NSString
                        self.collectionArray = collectionStr.components(separatedBy: ",")
                        self.collectionArray.removeFirst()
                        print(self.collectionArray)
                    }
                }
        }
        self.collectionTableView.reloadData()
        self.refreshAction.endRefreshing()
    }
    

    @IBOutlet weak var collectionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的收藏"
        let item = UIBarButtonItem(title: "我的", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // 下拉刷新
        refreshAction.attributedTitle = NSAttributedString.init(string: "正在刷新")
        refreshAction.addTarget(self, action: #selector(getCollection), for: .valueChanged )
        collectionTableView.addSubview(refreshAction)
        collectionTableView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        
        // 注册Cell
        let cellNib = UINib(nibName: "myCollectionTableViewCell", bundle: nil)
        collectionTableView.register(cellNib, forCellReuseIdentifier: "myCollection")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
