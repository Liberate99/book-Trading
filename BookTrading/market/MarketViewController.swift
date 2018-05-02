//
//  MarketViewController.swift
//  BookTrading
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //tableView
    @IBOutlet weak var underTableView: UITableView!
    
    
//    func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent
//    }
    
//    let cellIdentifier = "myCell"
//
//
//    private func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath:IndexPath!) -> UITableViewCell!{
//        let mycell: MarketTableViewCell = underTableView!.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! MarketTableViewCell
//        return mycell
//    }
    
    var tableData: [String] = ["BMW", "Ferrari", "Lambo"]
    
//    //颜色渐变
//    func turquoiseColor() -> CAGradientLayer {
//        let topColor = UIColor.clear
//        let bottomColor = UIColor.gray
//        
//        //let gradientColors: Array <AnyObject> = [topColor.cgColor, bottomColor.cgColor]
//        let gradientColors = [topColor.cgColor, bottomColor.cgColor]
//        
//        //let gradientLocations: Array <AnyObject> = [0.0 as AnyObject, 1.0 as AnyObject]
//        let gradientLocations:[NSNumber] = [0.0, 1.0]
//        
//        let gradientLayer: CAGradientLayer = CAGradientLayer()
//        gradientLayer.colors = gradientColors
//        gradientLayer.locations = gradientLocations as? [NSNumber]
//        return gradientLayer
//    }
    
    //继承tableviewdatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MarketTableViewCell = self.underTableView.dequeueReusableCell(withIdentifier: "cell") as! MarketTableViewCell
        cell.cellTitleLabel.text = tableData[indexPath.row]
        cell.bookImageBackground.image = UIImage(named: "book.png")
        //cell.cellImg.image = UIImage(named: tableData[indexPath.row])
        
//        //调用渐变
//        let background = turquoiseColor()
////        background.frame = cell.bounds
//        background.frame = cell.bounds
//        cell.blackBackgroundView.layer.insertSublayer(background, at: 1)
        return cell
    }
//    //设置单元格的大小
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    //设置不同种类的单元格的样式有多少
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
        
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.light)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]//NSAttributedStringKey
        underTableView.backgroundColor = UIColor.gray
        
        
        //注册cell
        let cellNib = UINib(nibName: "MarketTableViewCell", bundle: nil)
        underTableView.register(cellNib, forCellReuseIdentifier: "cell")
        
        
//        //注册
//        self.underTableView!.register(UINib(nibName: "MyCell", bundle:nil), forCellReuseIdentifier: cellIdentifier)
//        //设置数据源
//        self.underTableView.dataSource = self as? UITableViewDataSource;
        //设置代理
        
        
        
        
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

}
