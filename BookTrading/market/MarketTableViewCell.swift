//
//  MarketTableViewCell.swift
//  BookTrading
//
//  Created by apple on 2018/5/1.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class MarketTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var bookImageBackground: UIImageView!
    //    @IBOutlet weak var blackBackgroundView: UIView!
    //    @IBOutlet weak var blackLayer: UIView!
    
    @IBOutlet weak var promulgatorImage: UIImageView!
    @IBOutlet weak var promulgatorImageUnderLayer: UIView!
    @IBOutlet weak var promulgatorNameLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellContentLabel: UILabel!

    
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.promulgatorImageUnderLayer.layer.cornerRadius = 27
        self.promulgatorImageUnderLayer.layer.masksToBounds = true
        
        self.promulgatorImage.layer.cornerRadius = 25
        self.promulgatorImage.layer.masksToBounds = true
        
        // 两行
        self.cellContentLabel.numberOfLines = 2
        // 隐藏尾部并显示省略号
        self.cellContentLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail

        // 调用渐变
        let background = turquoiseColor()
//        background.frame.origin = CGPoint.zero
//        background.frame = bookImageBackground.frame
        background.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: 180))
        bookImageBackground.layer.insertSublayer(background, at: 0)
        //bookImageBackground.addSubview(gv)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
