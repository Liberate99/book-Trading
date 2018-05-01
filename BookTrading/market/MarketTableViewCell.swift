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
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
