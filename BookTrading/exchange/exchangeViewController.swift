//
//  exchangeViewController.swift
//  BookTrading
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 Liberate. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class model {
    var bookname:String = ""
    var price:Float = 0
}

class exchangeViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
//    let data = ["bookname" : "1q84", "price" : 30] as [String : Any]
    
    var userid = ""
    
    // 数据源
    var bookArray = [model]()
    /**
    *   获取数据 getBookInfo()
    */

    func getBookInfo(){
        
        
        let parameter = ["promulgatorid" :  userid]

        Alamofire.request("http://127.0.0.1:8080/book/selectBookByUserId?", method: .get, parameters: parameter, encoding: URLEncoding.default)
            .responseJSON {
                (response) in
                // 有错误就打印错误，没有就解析数据
                if let Error = response.result.error{
                    print(Error)
                } else if let jsonresult = response.result.value {
                    // 用 SwiftyJSON 解析数据
                    let JSOnDictory = JSON(jsonresult)
                    //let JSONDictory = jsonresult.data
                    let data = JSOnDictory.array
                    for dataDic in data!{
                        let _model = model()
                        _model.bookname = dataDic["bookname"].string ?? ""
                        _model.price = dataDic["bookprice"].float ?? 0
                        self.bookArray.append(_model)
                        print(_model.bookname )
                        print(_model.price)
                    }
                    self.picker.reloadComponent(0)
                }
            }
    }
    
    // 选择框为 1 列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 选择框 行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("行数\(bookArray.count)")
        return bookArray.count
    }
    
    //设置pickerView各选项的内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,forComponent component: Int) -> String? {
        print("title:\(bookArray[row].bookname)   \(bookArray[row].price)")
        return "\(bookArray[row].bookname)  价格：\(bookArray[row].price)"
    }

    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var ok: UIButton!
    
    @IBAction func getPickerViewValue(_ sender: Any) {
        print(picker.selectedRow(inComponent: 0))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBookInfo()
        
        // dataSource
        picker.dataSource = self
        
        // delegate
        picker.delegate = self as? UIPickerViewDelegate
        
        
        
        SwiftNotice.showText("请选择用来交换的书籍")

        
        
        self.view.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.5)
        
        picker.layer.cornerRadius = 10
        picker.layer.masksToBounds = true
        
        ok.backgroundColor = UIColor.white
        ok.layer.cornerRadius = 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
