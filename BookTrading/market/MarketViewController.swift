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
    
    // 数据源
    var dataArray = [book]()
    
    // tableView
    @IBOutlet weak var underTableView: UITableView!
    
    var tableTitleData: [String] = ["《1Q84》有售", "《傲慢与偏见》有售", "《霍乱时期的爱情》有售"]
    var tablePictureData: [String] = ["1Q84", "傲慢与偏见", "霍乱时期的爱情"]
    var tableDescriptionData: [String] = ["《1Q84》是日本作家村上春树于2009年所发表的长篇小说。故事以双线（BOOK3为三线）进行，并以村上春树较少用的第三人称全知观点来说故事。",
                                          "《傲慢与偏见》是简·奥斯汀的代表作。小说讲述了乡绅之女伊丽莎白·班内特的爱情故事。这部作品以日常生活为素材,以反当时社会上流行的感伤小说的内容。",
                                          "《霍乱时期的爱情》是加西亚·马尔克斯获得诺贝尔文学奖后出版的第一部小说，讲述了一段跨越半个多世纪的爱情史诗，穷尽了所有爱情的可能性：忠贞的、隐秘的、粗暴的、羞怯的、柏拉图式的、放荡的、转瞬即逝的、生死相依的。。再现了时光的无情流逝，被誉为“人类有史以来最伟大的爱情小说”，是20世纪最重要的经典文学巨著之一。"]

    // 继承tableviewdatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MarketTableViewCell = self.underTableView.dequeueReusableCell(withIdentifier: "cell") as! MarketTableViewCell
        
        
        /**
          *  加载数据
        */
        cell.cellTitleLabel.text = "《\(dataArray[indexPath.row].bookName)》有售"
        
        // 加载线上图片
        let url = URL(string: dataArray[indexPath.row].picURL)
        let data = NSData(contentsOf: url!)
        if data != nil {
            cell.bookImageBackground.image = UIImage(data: data as! Data)
        } else {
            cell.bookImageBackground.image = UIImage(named: "无法加载图片")
            print("picture is nil! /n")
        }
        
        //cell.bookImageBackground.image = UIImage(named: tablePictureData[indexPath.row])
        cell.cellContentLabel.text = dataArray[indexPath.row].bookContent
        
        return cell
    }
    
    
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 状态栏白色
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.light)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]//NSAttributedStringKey
        underTableView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        // 获取tableView数据
        Alamofire.request("http://127.0.0.1:8080/book/selectAllBooks", method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON {
            (response) in
            // 有错误就打印错误，没有就解析数据
            if let Error = response.result.error{
                print(Error)
            } else if let jsonresult = response.result.value {
                // 用 SwiftyJSON 解析数据
                let JSOnDictory = JSON(jsonresult)
                print(JSOnDictory)
                print(JSOnDictory[0])
                //let JSONDictory = jsonresult.data
                let data = JSOnDictory.array
                print("data: \(data)")
                for dataDic in data!{
                    let model = book()
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
                    self.dataArray.append(model)
                }
                self.underTableView.reloadData()

                print(jsonresult)
            }
        }
//        Alamofire.request("http://127.0.0.1:8080/book/selectAllBooks", method: .get, parameters: nil, encoding: URLEncoding.default)
//            .validate()
//            .response {response in
//                print("Request: \(String(describing: response.request))")
//                print("Response: \(response.response)")
//                print("Error: \(response.error)")
//                if let jsonresult = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
//                    print("Data: \(utf8Text)")
//                }
//        }
        
        // 注册cell
        let cellNib = UINib(nibName: "MarketTableViewCell", bundle: nil)
        underTableView.register(cellNib, forCellReuseIdentifier: "cell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
