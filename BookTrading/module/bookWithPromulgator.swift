//
//  bookWithPromulgator.swift
//  BookTrading
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class bookWithPromulgator: NSObject {
    // 13
    
    var bookId: Int = 0
    var bookName: String = ""
    var autherName: String = ""
    var picURL: String = ""
    var promulgatorId: Int = 0
    var purchaserId: Int = 0 // 购买者
    var status: Int = 0
    var bookPrice: Float = 0
    var bookContent: String = ""
    var publishDate: String = ""

    var userName: String = "" // 发布者
    var passWord: String = ""
    var userPic: String = ""
}
