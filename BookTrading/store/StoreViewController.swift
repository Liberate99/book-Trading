//
//  StoreViewController.swift
//  BookTrading
//
//  Created by apple on 2018/4/27.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    
    @IBOutlet weak var recommendScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // statusBar
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        
        // navigater
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.light)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]
        
        // scrollView
        recommendScrollView.backgroundColor = UIColor.green
        recommendScrollView.isPagingEnabled = true
        recommendScrollView.contentSize = CGSize(width: (self.view.frame.size.width)*3, height: (self.view.frame.size.height)/3)
        recommendScrollView.showsVerticalScrollIndicator = false
        recommendScrollView.showsHorizontalScrollIndicator = false
        recommendScrollView.scrollsToTop = false
        let numOfPages = 3
        for i in 0...numOfPages{
            var <#name#> = <#value#>
            
        }
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

}
