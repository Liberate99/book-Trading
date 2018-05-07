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
    
    var courses = [["title":"《1Q84》",         "content":"《傲慢与偏见》是简·奥斯汀的代表作。小说讲述了乡绅之女伊丽莎白·班内特的爱情故事。",    "pic":"1Q84.png"],
                   ["title":"《傲慢与偏见》",     "content":"《傲慢与偏见》是简·奥斯汀的代表作。小说讲述了乡绅之女伊丽莎白·班内特的爱情故事。",    "pic":"傲慢与偏见.png"],
                   ["title":"《霍乱时期的爱情》",  "content":"《霍乱时期的爱情》是加西亚·马尔克斯获得诺贝尔文学奖后出版的第一部小说，讲述了一段跨越半个多世纪的爱情史诗，穷尽了所有爱情的可能性：忠贞的、隐秘的、粗暴的、羞怯的、柏拉图式的、放荡的、转瞬即逝的、生死相依的……再现了时光的无情流逝，被誉为“人类有史以来最伟大的爱情小说”，是20世纪最重要的经典文学巨著之一。",  "pic":"霍乱时期的爱情.png"]]
    
    //颜色渐变
    func turquoiseColor() -> CAGradientLayer {
        let topColor = UIColor.clear
        let bottomColor = UIColor.black.withAlphaComponent(0.7)
        
        //let gradientColors: Array <AnyObject> = [topColor.cgColor, bottomColor.cgColor]
        let gradientColors = [topColor.cgColor, bottomColor.cgColor]
        
        //let gradientLocations: Array <AnyObject> = [0.0 as AnyObject, 1.0 as AnyObject]
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as? [NSNumber]
        
        return gradientLayer
    }
    
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
            
            //let GradientView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 230))
            let background = turquoiseColor()
            background.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width , height: 230)
            page.layer.insertSublayer(background, at: 0)
            
            let title = UILabel(frame: CGRect(x: 0, y: 100, width: 375, height: 50))
            title.text = course["title"]
            //title.font.withSize(40)
            title.font = UIFont(name: "Helvetica", size: 20)
            title.textColor = UIColor.white
            title.textAlignment = NSTextAlignment.center
            page.addSubview(title)
            
            let content = UILabel(frame: CGRect(x: 30, y: 120, width: 315, height: 100))
            //content.text = course["content"]
            content.font = UIFont(name: "Helvetica", size: 12)
            content.textColor = UIColor.white
            
            // 通过富文本来设置行间距
            let paraph = NSMutableParagraphStyle()
            // 将行间距设置为28
            paraph.lineSpacing = 7
            // 字体居中
            paraph.alignment = NSTextAlignment.center
            // 字体尾部截取
            paraph.lineBreakMode = NSLineBreakMode.byTruncatingTail
            // 样式属性集合
            let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12),
                              NSAttributedStringKey.paragraphStyle: paraph]
            content.attributedText = NSAttributedString(string: course["content"]!, attributes: attributes)
            content.numberOfLines = 2
            page.addSubview(content)
        }
        
        // 页控件属性
        pageControl.numberOfPages = courses.count
        pageControl.currentPage = 0
        
        // 添加页控制器
        self.view.addSubview(pageControl)
        
        //设置页空间点击事件
        pageControl.addTarget(self, action: Selector(("pageChanged")), for: UIControlEvents.valueChanged)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
