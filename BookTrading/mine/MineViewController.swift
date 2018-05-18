//
//  MineViewController.swift
//  BookTrading
//
//  Created by apple on 2018/4/27.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit


class MineViewController: UIViewController {

    var balanceNum = 100
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 加载线上图片
        let url = URL(string: "http://i3.sinaimg.cn/edu/2013/0411/U3835P42DT20130411102511.jpg")
        let data = NSData(contentsOf: url!)
        if data != nil {
            userPic.image = UIImage(data: data as! Data)
        } else {
            userPic.image = UIImage(named: "userPic")
            print("picture is nil! /n")
        }
        
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
        balance.setTitle("    我的余额        \(balanceNum)", for:.normal)
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
