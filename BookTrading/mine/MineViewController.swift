//
//  MineViewController.swift
//  BookTrading
//
//  Created by apple on 2018/4/27.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MineViewController: UIViewController {

    var balanceNum = 100
    
    var User: user = user()
    
    var base: baseUserClass = baseUserClass()
    
    @IBOutlet var backGroundView: UIView!
    @IBOutlet weak var userUnderView: UIView!
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userIntro: UILabel!
    @IBOutlet weak var myGoods: UIButton!
    @IBOutlet weak var myCollection: UIButton!
    @IBOutlet weak var balance: UIButton!
    @IBOutlet weak var setting: UIButton!
    
    // myGoods tapped
    @objc func myGoodsTapped(_ button:UIButton){
        print("我的发布")
    }
    
    // getUserInfo
    func getUserInfo(username: String){
        Alamofire.request("http://127.0.0.1:8080/user/selectUserByName?", method: .get, parameters: ["username" : username], encoding: URLEncoding.default)
            .validate()
            .responseJSON{
                (response) in
                // 有错误就打印错误，没有就解析数据
                if let Error = response.result.error{
                    print(Error)
                } else if let jsonresult = response.result.value {
                    // 用 SwiftyJSON 解析数据
                    let JSOnDictory = JSON(jsonresult)
                    print(JSOnDictory)
                    let data = JSOnDictory.array
                    self.User.userId = data![0]["userid"].int ?? 0
                    // 加载用户名
                    self.User.userName = data![0]["username"].string ?? ""
                    self.userName.text = self.User.userName
                    // 加载用户余额
                    self.User.balance = data![0]["balance"].float ?? 0
                    self.balance.setTitle("      我的余额                                              \(self.User.balance)", for: .normal)
                    self.User.userPic = data![0]["userpic"].string ?? ""
                    // 加载用户图片
                    let url = URL(string: self.User.userPic)
                    let _data = NSData(contentsOf: url!)
                    if _data != nil {
                        self.userPic.image = UIImage(data: _data! as Data)
                    } else {
                        self.userPic.image = UIImage(named: "userPic")
                        print("picture is nil! /n")
                    }
                }
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(base.cacheGetString(key: "username"))
        
        getUserInfo(username: self.base.cacheGetString(key: "username"))
        
        
        // 头像圆角
        userPic.layer.cornerRadius = 35
        userPic.layer.masksToBounds = true
        
        // myGoods
        myGoods.backgroundColor = UIColor.white
        myGoods.addTarget(self, action: #selector(myGoodsTapped(_:)), for: .touchUpInside)
        
        // myCollection
        myCollection.backgroundColor = UIColor.white
        
        // liked
        balance.backgroundColor = UIColor.white
        //balance.setTitle("    我的余额        \(balanceNum)", for:.normal)
            //?.text = "我的余额        \(balanceNum)"
        
        // setting
        setting.backgroundColor = UIColor.white
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.light)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
