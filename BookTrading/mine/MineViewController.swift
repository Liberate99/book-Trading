//
//  MineViewController.swift
//  BookTrading
//
//  Created by apple on 2018/4/27.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit


class MineViewController: UIViewController {

    @IBOutlet var backGroundView: UIView!
    @IBOutlet weak var userUnderView: UIView!
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userIntro: UILabel!
    @IBOutlet weak var myGoods: UIButton!
    @IBOutlet weak var myCollection: UIButton!
    @IBOutlet weak var liked: UIButton!
    @IBOutlet weak var setting: UIButton!
    
    // myGoods tapped
    @objc func myGoodsTapped(_ button:UIButton){
        print("我的发布")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = URL(string: "http://www.ouou.cn/uploadfile/2017/0116/20170116062809428.jpg")
        let data = NSData(contentsOf: url!)
        if data != nil {
            userPic.image = UIImage(data: data as! Data)
        } else {
            userPic.image = UIImage(named: "userPic")
            print("picture is nil! /n")
        }
        
        userPic.layer.cornerRadius = 35
        userPic.layer.masksToBounds = true
        
        // myGoods
        myGoods.backgroundColor = UIColor.white
        myGoods.addTarget(self, action: #selector(myGoodsTapped(_:)), for: .touchUpInside)
        
        // myCollection
        myCollection.backgroundColor = UIColor.white
        
        // liked
        liked.backgroundColor = UIColor.white
        
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
