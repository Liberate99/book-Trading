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
    
    var tableTitleData: [String] = ["《1Q84》有售", "《傲慢与偏见》有售", "《傲慢与偏见》有售"]
    var tablePictureData: [String] = ["1Q84", "傲慢与偏见", "傲慢与偏见"]
    var tableDescriptionData: [String] = ["《1Q84》是日本作家村上春树于2009年所发表的长篇小说。故事以双线（BOOK3为三线）进行，并以村上春树较少用的第三人称全知观点来说故事。", "《傲慢与偏见》是简·奥斯汀的代表作。小说讲述了乡绅之女伊丽莎白·班内特的爱情故事。这部作品以日常生活为素材,以反当时社会上流行的感伤小说的内容。", "《傲慢与偏见》是简·奥斯汀的代表作。小说讲述了乡绅之女伊丽莎白·班内特的爱情故事。这部作品以日常生活为素材,以反当时社会上流行的感伤小说的内容。"]

    //继承tableviewdatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTitleData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MarketTableViewCell = self.underTableView.dequeueReusableCell(withIdentifier: "cell") as! MarketTableViewCell
        
        cell.cellTitleLabel.text = tableTitleData[indexPath.row]
        cell.bookImageBackground.image = UIImage(named: tablePictureData[indexPath.row])
        cell.cellContentLabel.text = tableDescriptionData[indexPath.row]
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
        
        //状态栏白色
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.light)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]//NSAttributedStringKey
        underTableView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        //注册cell
        let cellNib = UINib(nibName: "MarketTableViewCell", bundle: nil)
        underTableView.register(cellNib, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
