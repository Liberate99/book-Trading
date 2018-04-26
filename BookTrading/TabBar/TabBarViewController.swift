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
    
    var _backView:UIView? = nil
    //var items:NSArray = []
    let NameArr = ["书市","书库","推荐","我的"]
    let PicArr = ["书市黑","书库黑","推荐黑","我的黑"]
    let PicSelectArr = ["书市白","书库白","推荐白","我的白"]
    let VCArr = [MarketViewController(),StoreViewController(),RecommendViewController(),MineViewController()]
    
    //初始化数组
    var NavVCArr:[NSObject] = [NSObject]()
    var nav:UINavigationController = UINavigationController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CreatTabBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //创建tabBar
    func CreatTabBar()  {
        
        _backView = UIView(frame:CGRect(x:0,y:0,width:SCREEN_WIDTH,height:49))
        
        let  MarketVC  = MarketViewController()
        MarketVC.title = "书市"
        let MarketNav = UINavigationController(rootViewController:MarketVC)
        MarketNav.tabBarItem.title = "书市"
        MarketNav.tabBarItem.image = UIImage(named:"书市黑")
        MarketNav.tabBarItem.selectedImage = UIImage(named:"书市白")
        
        let  StoreVC  = StoreViewController()
        StoreVC.title = "书库"
        let StroeNav = UINavigationController(rootViewController:StoreVC)
        StroeNav.tabBarItem.title = "书库"
        StroeNav.tabBarItem.image = UIImage(named:"书库黑")
        StroeNav.tabBarItem.selectedImage = UIImage(named:"书库白")
        
        let  RecomVC  = RecommendViewController()
        RecomVC.title = "推荐"
        let RecomNav = UINavigationController(rootViewController:RecomVC)
        RecomNav.tabBarItem.title = "推荐"
        RecomNav.tabBarItem.image = UIImage(named:"推荐黑")
        RecomNav.tabBarItem.selectedImage = UIImage(named:"推荐白")
        
        let  MyVC  = MineViewController()
        MyVC.title = "我的"
        let MyNav = UINavigationController(rootViewController:MyVC)
        MyNav.tabBarItem.title = "我的"
        MyNav.tabBarItem.image = UIImage(named:"我的黑")
        MyNav.tabBarItem.selectedImage = UIImage(named:"我的白")
        
        // 添加工具栏
        let items = [MarketNav,StroeNav,RecomNav,MyNav]
        self.viewControllers = items
        
//        for  i in 0 ..< items.count {
//            /*
//             (items[i] as AnyObject) 相当于 self.navigationController?
//             **/
//            //设置导航栏的背景图片 （优先级高）
//            (items[i] as AnyObject).navigationBar.setBackgroundImage(UIImage(named:"NavigationBar"), for:.default)
//            //设置导航栏的背景颜色 （优先级低）
//            (items[i] as AnyObject).navigationBar.barTintColor = UIColor.orange
//            //设置导航栏的字体颜色
//            (items[i] as AnyObject).navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.red]
//        }
        
        
        /**
         for循环控制器数组 写法
         
         for  M in 0 ..< VCArr.count {
         nav = UINavigationController(rootViewController:(VCArr[M] as AnyObject as! UIViewController))
         
         nav.tabBarItem.title = NameArr[M]
         nav.tabBarItem.image = UIImage(named:PicArr[M])
         nav.tabBarItem.selectedImage = UIImage(named:PicSelectArr[M])
         VCArr[M].title = NameArr[M]
         NavVCArr.append(nav)
         }
         // 添加工具栏
         // items = [MainNav,ClassNav,CartNav,MyNav]
         self.viewControllers = NavVCArr as? [UIViewController]
         for  i in 0 ..< NavVCArr.count {
         /*
         (items[i] as AnyObject) 相当于 self.navigationController?
         **/
         //设置导航栏的背景图片 （优先级高）
         (NavVCArr[i] as AnyObject).navigationBar.setBackgroundImage(UIImage(named:"NavigationBar"), for:.default)
         //设置导航栏的背景颜色 （优先级低）
         (NavVCArr[i] as AnyObject).navigationBar.barTintColor = UIColor.orange
         //设置导航栏的字体颜色
         (NavVCArr[i] as AnyObject).navigationBar.titleTextAttributes =
         [NSForegroundColorAttributeName: UIColor.red]
         
         }
         */
        //tabBar 底部工具栏背景颜色 (以下两个都行)
        self.tabBar.barTintColor = UIColor.orange
        self.tabBar.backgroundColor = UIColor.brown
        
        
//        //设置 tabBar 工具栏字体颜色 (未选中  和  选中)
//        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:UIColor.white, forKey:NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject], for:UIControlState.normal);
//        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:UIColor.red, forKey:NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject], for:UIControlState.selected);
//        
        
        
        
    }

}
