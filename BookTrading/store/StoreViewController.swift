//
//  StoreViewController.swift
//  BookTrading
//
//  Created by apple on 2018/4/27.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize,false,1);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
}

class StoreViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var recommendScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var courses = [["name":"Swift","pic":"1Q84.png"],
                   ["name":"O-bjective","pic":"傲慢与偏见.png"],
                   ["name":"C++","pic":"1Q84.png"]]
    
    // UIScrollViewDelegate方法，每次滚动结束后调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 通过scrollView内容的偏移量计算当前显示的是第几页
        let page = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
        
        // 设置pageController的当前页
        pageControl.currentPage = page
    }
    
    // 点击页控件时事件处理
    func pageChange(sender: UIPageControl){
        
        // 根据点击的页数，计算scrollView需要显示的偏移量
        var frame = recommendScrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        
        // 展现当前页面内容
        recommendScrollView.scrollRectToVisible(frame, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // statusBar
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        
        // navigater
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.light)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]
        
        /*
         * scrollView && pageControl
         */
        // scrollView 不回弹
        recommendScrollView.bounces = false
        
        // 尺寸
        recommendScrollView.contentSize = CGSize(width: 375*CGFloat(self.courses.count), height: 230)
        
        //pageControl
        pageControl.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 270)
        
        // 关闭滚动显示条
        recommendScrollView.showsHorizontalScrollIndicator = false
//        recommendScrollView.showsVerticalScrollIndicator = false
//        recommendScrollView.scrollsToTop = false
        
        // 协议代理，在本类中处理滚动事件
        recommendScrollView.delegate = self
        
        // 滚动时只能停留到某一页
        recommendScrollView.isPagingEnabled = true
        
        // 添加页面到滚动页面里
        let size = recommendScrollView.bounds.size
        for (seq,course) in courses.enumerated() {
            let page = UIImageView(frame: CGRect(x: CGFloat(seq)*size.width, y: 0, width: 375, height: 230))
            let _reSize = CGSize(width: 375, height: 230)
            page.image = UIImage(named: course["pic"]!)!.reSizeImage(reSize: _reSize)
            recommendScrollView.addSubview(page)
        }
        
        // 页控件属性
        pageControl.numberOfPages = courses.count
        pageControl.currentPage = 0
        
        // 添加页控制器
        self.view.addSubview(pageControl)
        
        //设置页空间点击事件
        pageControl.addTarget(self, action: "pageChanged", for: UIControlEvents.valueChanged)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
