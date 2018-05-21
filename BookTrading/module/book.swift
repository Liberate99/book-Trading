//
//  book.swift
//  BookTrading
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class book: NSObject {
    var bookId: Int = 0
    var bookName = ""
    var autherName = ""
    var picURL = ""
    var promulgatorId: Int = 0
    var purchaserId: Int = 0
    var status: Int = 0      // 0是未卖出； 1是已卖出，2是已交换
    var bookPrice: Float = 0
    var bookContent = ""
    var publishDate = ""
}
