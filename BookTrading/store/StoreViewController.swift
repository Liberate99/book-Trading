import UIKit
import Alamofire
import SwiftyJSON

extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize,false,1);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
}

class StoreViewController: UIViewController,UIScrollViewDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    /**
        数据源
    */
    // scrollview + pagecontrol
    var courses = [["title":"《1Q84》",         "content":"《傲慢与偏见》是简·奥斯汀的代表作。小说讲述了乡绅之女伊丽莎白·班内特的爱情故事。",    "pic":"1Q84.png"],
                   ["title":"《傲慢与偏见》",     "content":"《傲慢与偏见》是简·奥斯汀的代表作。小说讲述了乡绅之女伊丽莎白·班内特的爱情故事。",    "pic":"傲慢与偏见.png"],
                   ["title":"《霍乱时期的爱情》",  "content":"《霍乱时期的爱情》是加西亚·马尔克斯获得诺贝尔文学奖后出版的第一部小说，讲述了一段跨越半个多世纪的爱情史诗，穷尽了所有爱情的可能性：忠贞的、隐秘的、粗暴的、羞怯的、柏拉图式的、放荡的、转瞬即逝的、生死相依的……再现了时光的无情流逝，被誉为“人类有史以来最伟大的爱情小说”，是20世纪最重要的经典文学巨著之一。",  "pic":"霍乱时期的爱情.png"]]
    // tableview
    var bookArray = [book]()
    
    // scrollView + pageControl
    let scrollView = UIScrollView(frame: CGRect(x:0, y:64, width:UIScreen.main.bounds.width,height: 230))
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:0,y: 244, width:UIScreen.main.bounds.width-50, height:50))
    
    // searchBar + tableView
    let searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 294, width: UIScreen.main.bounds.width, height: 60))// y = 294
    let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 354, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))// y = 370
    
    
    
    // tableview 代理方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchCell: searchTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "searchCell") as! searchTableViewCell
        print("!!!!!!!!!!!!!!!!!!!!!!!!!")
        print(bookArray)
        
        searchCell.price.text = "\(bookArray[indexPath.row].bookPrice)"
        searchCell.bookname.text = "\(bookArray[indexPath.row].bookName)"
        searchCell.auther.text = "\(bookArray[indexPath.row].autherName)"
        return searchCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let BWP = bookDetialViewController()
        BWP.bookId = bookArray[indexPath.row].bookId
        BWP.navigationItem.title = bookArray[indexPath.row].bookName
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(BWP, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    // searchbar 代理方法
    // 每次改变内容的时候调用此方法
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("text changed!")
        if searchText == "" {
            print("nothing")
        }else{
            getBooks(str: searchText)
        }
    }
    // 搜索触发事件，点击虚拟键盘上的search按钮触发此方法
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search did click")
        searchBar.resignFirstResponder()
        getBooks(str: searchBar.text!)
        self.tableView.reloadData()

    }
    
    // 请求数据
    @objc func getBooks(str: String){
        bookArray = []
        print("get books  \(str)")
        let _parameter = ["_str" : str]
        Alamofire.request("http://127.0.0.1:8080/book/selectBookByBooknameOrAuthername?", method: .get, parameters: _parameter, encoding: URLEncoding.default)
            .validate()
            .responseJSON{
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
                        if dataDic["status"].int != 0 {
                            continue
                        }
                        let model = book()
                        //  ??  NIL合并运算符，它的作用是如果 A 不是NIL 就返回前面可选类型参数 A 的确定值， 如果 A 是NIL 就返回后面 B 的值
                        model.bookId = dataDic["bookid"].int ?? 0
                        model.bookName = dataDic["bookname"].string ?? ""
                        model.autherName = dataDic["authername"].string ?? ""
                        model.status = dataDic["status"].int ?? 0
                        model.bookPrice = dataDic["bookprice"].float ?? 0
                        self.bookArray.append(model)
                        print(model.bookName)
                    }
                    print(self.bookArray)
                }
                self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.3)

        //statusBar
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        
        // navigater
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.light)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]
        // Do any additional setup after loading the view, typically from a nib.
        
        /**
         * scrolView
         */
        scrollView.delegate = self
        // scrollView 不回弹
        scrollView.bounces = false
        // 滚动时只能停留到某一页
        scrollView.isPagingEnabled = true
        // 关闭滚动显示条
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        /**
         * searchBar + tableView
         */
        self.searchBar.delegate = self
        self.searchBar.placeholder = "搜索书名或作者"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // 注册cell
        let cellNib = UINib(nibName: "searchTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "searchCell")
        
        // searchBar tintcolor
        searchBar.barTintColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.5)
        
        // tableview backgroundcolor
        //tableView.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.5)
        
        // searchBar 键盘类型
        // searchBar.keyboardType = UIKeyboardType.
        
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        
        
        for (seq,course) in courses.enumerated() {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(seq)
            frame.size = self.scrollView.frame.size
            
            let subView = UIImageView(frame: frame)
            //subView.backgroundColor = colors[index]
            subView.image = UIImage(named: course["pic"]!)
            //!.reSizeImage(reSize: reSize)
            self.scrollView .addSubview(subView)
            
            let background = turquoiseColor()
            background.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width , height: 230)
            subView.layer.insertSublayer(background, at: 0)
            
            let title = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 50))
            title.text = course["title"]
            //title.font.withSize(40)
            title.font = UIFont(name: "Helvetica", size: 20)
            title.textColor = UIColor.white
            title.textAlignment = NSTextAlignment.center
            subView.addSubview(title)
            
            let content = UILabel(frame: CGRect(x: 15, y: 120, width: UIScreen.main.bounds.width-30, height: 100))
            //content.text = course["content"]
            content.font = UIFont(name: "Helvetica", size: 12)
            content.textColor = UIColor.white
            
            // 通过富文本来设置行间距
            let paraph = NSMutableParagraphStyle()
            // 将行间距设置为28
            paraph.lineSpacing = 7
            // 字体居中
            paraph.alignment = NSTextAlignment.center
            // 字体尾部截取
            paraph.lineBreakMode = NSLineBreakMode.byTruncatingTail
            // 样式属性集合
            let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12),
                              NSAttributedStringKey.paragraphStyle: paraph]
            content.attributedText = NSAttributedString(string: course["content"]!, attributes: attributes)
            content.numberOfLines = 2
            subView.addSubview(content)
        }
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * CGFloat(self.courses.count),height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        
        // 设置pageControl
        configurePageControl()
        
        // 设置页控件点击事件
        
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = courses.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.view.addSubview(pageControl)
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



