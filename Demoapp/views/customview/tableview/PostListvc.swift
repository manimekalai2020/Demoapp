//
//  PostListvc.swift
//  Demoapp
//
//  Created by apple on 17/11/20.
//

import UIKit
import Alamofire
import ObjectMapper
import RxSwift
import RxCocoa

struct Manager {

static var results = [Int]()

}
class PostListvc: ViewController, UITableViewDelegate {
    var Postlist:[PostlistModel] = []
    var isLikeBtnSelected = false
    var SaveArray : [Int] = []
    var postListData = [PostlistModel]()
    var postListDataModel: PostlistModel?
    var HostURL = "https://jsonplaceholder.typicode.com/posts"

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        if let arr = UserDefaults.standard.array(forKey: "saveData") as? [Int]{
            Manager.results = arr
        }
        super.viewDidLoad()
        self.tableview.register(UINib(nibName: "Postlistcell", bundle: nil), forCellReuseIdentifier: "Postlistcell")
         Apicall()
    }
    func obdservertable(){
        let items = Observable.just(Postlist)
        items
            .bind(to: tableview.rx.items(cellIdentifier: "Postlistcell", cellType: Postlistcell.self)) { (row, element, cell) in
                cell.Title_label.text = element.title
                cell.Description_label.text = element.body
                cell.Favbutton.tag = row
                if Manager.results.contains(row) {
                    cell.Favbutton.setImage(#imageLiteral(resourceName: "star_color"), for: .normal)

                  //do something
                }else{
                    cell.Favbutton.setImage(#imageLiteral(resourceName: "star_icon"), for: .normal)
                }
            }
            .disposed(by: disposeBag)

    }
  
 
    func Apicall(){
        
        if Reachability.isConnectedToNetwork(){
            JsonHandler.StartRequest(HostURL, method: .get, params: nil , ShowIt: false, setview: self.view, success: { [self] (Responce) in
            let jsonarray = Responce.arrayObject as NSArray?
            UserDefaults.standard.set(jsonarray, forKey: "jsonData")
            self.Postlist = Mapper<PostlistModel>().mapArray(JSONArray: jsonarray as! [[String : Any]])
                self.obdservertable()
          },EmptyData: { (Responce) in
           
          }) { (Error) in
          }
        }else{
            let jsonarray = UserDefaults.standard.array(forKey: "jsonData")!
            self.Postlist = Mapper<PostlistModel>().mapArray(JSONArray: jsonarray as! [[String : Any]])
            self.obdservertable()
        }
    }
    

}
