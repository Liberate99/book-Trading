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
    
    var userid = 0
    var username = ""
    var price: Float = 0
    var bookid = 0
    
    
    
    // 数据源
    var bookArray = [model]()
    
    
    /**
    *   获取数据 getBookInfo()
    */
    func getBookInfo(){
        
        // 用户ID相等的情况下，使要交换书的价格小于等于想要书的价格
        let parameter = ["promulgatorid" :  userid , "price" : price] as [String : Any]
        print("=======================")
        print(parameter)
        
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
                    if data == [] {
                        SwiftNotice.showText("没有合适的交换书籍！")
                    }else {
                        for dataDic in data!{
                            let _model = model()
                            _model.bookname = dataDic["bookname"].string ?? ""
                            _model.price = dataDic["bookprice"].float ?? 0
                            self.bookArray.append(_model)
                        }
                        self.picker.reloadComponent(0)
                    }
                }
            }
    }
    
    // 更新 user--balance
    func reduceUserBalance(userid: Int, price: Float){
        let _parameter = ["userid": userid, "price": price] as [String : Any]
        Alamofire.request("http://127.0.0.1:8080/user/reduceUserBalance?", method: .post, parameters: _parameter, encoding: URLEncoding.default)
            .validate()
            .responseJSON{
                (response) in
                // 有错误就打印错误，没有就解析数据
                if let Error = response.result.error{
                    print(Error)
                } else if let jsonresult = response.result.value {
                    // 用 SwiftyJSON 解析数据
                    let data = JSON(jsonresult)
                    print(data)
                }
        }
    }
    
    // 更新 book--status、purchaserid
    func upDateStatus_PurchaserId(bookid: Int,purchaserid: Int,status: Int){
        let _parameter = ["bookid": bookid,"purchaserid": purchaserid, "status": status] as [String : Any]
        Alamofire.request("http://127.0.0.1:8080/book/upDateBookStatusANDPurchaserId?", method: .post, parameters: _parameter, encoding: URLEncoding.default)
            .validate()
            .responseJSON{
                (response) in
                // 有错误就打印错误，没有就解析数据
                if let Error = response.result.error{
                    print(Error)
                } else if let jsonresult = response.result.value {
                    // 用 SwiftyJSON 解析数据
                    let data = JSON(jsonresult)
                    if data != [] {
                        if data == 1 { print("更新成功！\(data)") }
                        else { print("更新失败") }
                    }
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
    @IBOutlet weak var calcleButton: UIButton!
    
    @IBAction func cancleAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getPickerViewValue(_ sender: Any) {
        print(picker.selectedRow(inComponent: 0))
        if (bookArray.count == 0){
            print("无")
        } else {
            print(bookArray[picker.selectedRow(inComponent: 0)].bookname)
            let exchangeAlert = UIAlertController(title: "以书易书", message: "确认要用《\(bookArray[picker.selectedRow(inComponent: 0)].bookname)》以及 \(Float(self.price)-bookArray[picker.selectedRow(inComponent: 0)].price) 积分交换此书吗？", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
                self.upDateStatus_PurchaserId(bookid: self.bookid, purchaserid: self.userid, status: 2)// status: 交换
                self.reduceUserBalance(userid: self.userid, price: self.price)
                SwiftNotice.showText("交换成功！")
            })
            exchangeAlert.addAction(cancelAction)
            exchangeAlert.addAction(okAction)
            self.present(exchangeAlert, animated: true, completion: nil)
            
        }
        self.dismiss(animated: true, completion: nil)

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
