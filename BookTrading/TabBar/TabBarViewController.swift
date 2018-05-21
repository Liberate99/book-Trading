//
//  TabBarViewController.swift
//  BookTrading
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    
//    //uername
//    var userKEY = ""
    
    var _backView:UIView? = nil
    //var items:NSArray = []
    let NameArr = ["书市","书库","消息","我的"]
    let PicArr = ["书市黑","书库黑","消息黑","我的黑"]
    let PicSelectArr = ["书市白","书库白","消息白","我的白"]
    let VCArr = [MarketViewController(),StoreViewController(),MessageViewController(),MineViewController()]
    
    //初始化数组
    var NavVCArr:[NSObject] = [NSObject]()
    var nav:UINavigationController = UINavigationController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CreatTabBar()
        self.tabBar.unselectedItemTintColor = UIColor.gray
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //创建tabBar
    func CreatTabBar()  {
        
        _backView = UIView(frame:CGRect(x:0,y:0,width:SCREEN_WIDTH,height:49))
        
        let  MarketVC  = MarketViewController()
        MarketVC.title = "书市"
        let MarketNav = UINavigationController(rootViewController:MarketVC)
        MarketNav.tabBarItem.title = "书市"
        MarketNav.tabBarItem.image = UIImage(named:"书市黑")
        MarketNav.tabBarItem.selectedImage = UIImage(named:"书市白")?.withRenderingMode(.alwaysOriginal)
        MarketNav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)

        
        let  StoreVC  = StoreViewController()
        StoreVC.title = "书库"
        let StroeNav = UINavigationController(rootViewController:StoreVC)
        StroeNav.tabBarItem.title = "书库"
        StroeNav.tabBarItem.image = UIImage(named:"书库黑")
        StroeNav.tabBarItem.selectedImage = UIImage(named:"书库白")?.withRenderingMode(.alwaysOriginal)
        StroeNav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)
        
        let  RecomVC  = MessageViewController()
        RecomVC.title = "消息"
        let RecomNav = UINavigationController(rootViewController:RecomVC)
        RecomNav.tabBarItem.title = "消息"
        RecomNav.tabBarItem.image = UIImage(named:"消息黑")
        RecomNav.tabBarItem.selectedImage = UIImage(named:"消息白")?.withRenderingMode(.alwaysOriginal)
        RecomNav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)
        
        let  MyVC  = MineViewController()
        MyVC.title = "我的"
        let MyNav = UINavigationController(rootViewController:MyVC)
        MyNav.tabBarItem.title = "我的"
        MyNav.tabBarItem.image = UIImage(named:"我的黑")
        MyNav.tabBarItem.selectedImage = UIImage(named:"我的白")?.withRenderingMode(.alwaysOriginal)
        MyNav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)
        
        // 添加工具栏
        let items = [MarketNav,StroeNav,RecomNav,MyNav]
        self.viewControllers = items
        
        //tabBar 底部工具栏背景颜色 (以下两个都行)
        self.tabBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)

    }
}
