//
//  goodsTableViewCell.swift
//  BookTrading
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class goodsTableViewCell: UITableViewCell {

    @IBOutlet weak var bookname: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
