//
//  book.swift
//  BookTrading
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class book: NSObject {
    var bookId = 0
    var bookName = ""
    var autherName = ""
    var picURL = ""
    var promulgatorId = 0
    var purchaserId = 0
    var status = 0      // 0是未卖出； 1是已卖出。
    var bookPrice = 0
    var bookContent = ""
    var publishDate = ""
}
