//
//  myCollectionTableViewCell.swift
//  BookTrading
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class myCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var bookname: UILabel!
    @IBOutlet weak var bookauther: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
