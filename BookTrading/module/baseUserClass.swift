//
//  baseUserClass.swift
//  BookTrading
//
//  Created by apple on 2018/5/19.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit

class baseUserClass: NSObject {
    
    //string
    func cacheSetString(key: String, value: String) {
        let userInfo = UserDefaults()
        userInfo.setValue(value, forKey: key)
    }
    
    func cacheGetString(key: String) -> String {
        let userInfo = UserDefaults()
        let tmpSign = userInfo.string(forKey: key)
        return tmpSign!
    }
    
//    //float
//    func cacheSetFloat(key: String, value: Float) {
//        let userInfo = UserDefaults()
//        userInfo.setValue(value, forKey: key)
//    }
//    
//    func cacheGetFloat(key: String) -> Float {
//        let userInfo = UserDefaults()
//        let tmpSign = userInfo.float(forKey: key)
//        return tmpSign
//    }
}
