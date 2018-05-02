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
    @IBOutlet weak var blackBackgroundView: UIView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellContentLabel: UILabel!
    @IBOutlet weak var autherNameLabel: UILabel!
    @IBOutlet weak var collectButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
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
        
        //调用渐变
        let background = turquoiseColor()
        //        background.frame = cell.bounds
        background.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width , height: self.bounds.size.height)
        self.bookImageBackground.layer.insertSublayer(background, at: 0)

//        // Initialization code
//        cellImg.layer.borderWidth = 1
//        cellImg.layer.masksToBounds = true
//        //cellImg.layer.cornerRadius = 31
        //bookImageBackground.image = UIImage(named: "book")
        //cellTitleLabel.backgroundColor = UIColor.brown
//        self.backgroundColor = UIColor.green
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
