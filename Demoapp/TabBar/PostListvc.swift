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
    var Postlist:[Todo] = []
    var isLikeBtnSelected = false
    var SaveArray : [Int] = []
    var savelist:[TodoModel] = []
    var postListData = [Todo]()
    var postListDataModel: Todo?


    @IBOutlet weak var tableview: UITableView!
    var HostURL = "https://jsonplaceholder.typicode.com/posts"
    override func viewDidLoad() {
        if let arr = UserDefaults.standard.array(forKey: "saveData") as? [Int]{
            Manager.results = arr
        }

        super.viewDidLoad()
        self.tableview.register(UINib(nibName: "Postlistcell", bundle: nil), forCellReuseIdentifier: "Postlistcell")
     //   tableview.register(UINib(nibName: "Postlistcell", bundle: nil), forCellReuseIdentifier: "Postlistcell")

        
    Apicall()
        
        
        
       

        // Do any additional setup after loading the view.
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
        tableview.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                DefaultWireframe.presentAlert("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)

        tableview.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)
 
    }
  
 
    func Apicall(){
        
        var todos = [Todo]()
        if Reachability.isConnectedToNetwork(){

            JsonHandler.StartRequest(HostURL, method: .get, params: nil , ShowIt: false, setview: self.view, success: { [self] (Responce) in
              print(Responce)

            let jsonarray = Responce.arrayObject as NSArray?
            UserDefaults.standard.set(jsonarray, forKey: "jsonData")
            print(UserDefaults.standard.array(forKey: "jsonData")!)
            self.Postlist = Mapper<Todo>().mapArray(JSONArray: jsonarray as! [[String : Any]])
                self.obdservertable()
          //  self.tableview.reloadData()
            
          },EmptyData: { (Responce) in
           
          }) { (Error) in
           
              print("adfasdfsdfsdfsadfasdfsadfsdfd,.fd,.f,d.f,df")
          }
        }else{
            let jsonarray = UserDefaults.standard.array(forKey: "jsonData")!
            self.Postlist = Mapper<Todo>().mapArray(JSONArray: jsonarray as! [[String : Any]])
            
            self.obdservertable()
            //self.tableview.reloadData()
        }
    }
    

}
