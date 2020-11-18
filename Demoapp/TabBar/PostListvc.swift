//
//  PostListvc.swift
//  Demoapp
//
//  Created by apple on 17/11/20.
//

import UIKit
import Alamofire
import ObjectMapper
struct Manager {

static var results = [Int]()


}
class PostListvc: UIViewController {
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
    Apicall()
        // Do any additional setup after loading the view.
    }
  
    @IBAction func Fvbutton_Tab(_ sender: UIButton) {
        let tagvalue = sender.tag
        if isLikeBtnSelected{
            isLikeBtnSelected = false
            sender.setImage(#imageLiteral(resourceName: "star_icon"), for: .normal)
            Manager.results = Manager.results.filter(){$0 != tagvalue}
            UserDefaults.standard.set(Manager.results, forKey: "saveData")

       }else{
        sender.setImage(#imageLiteral(resourceName: "star_color"), for: .normal)
        Manager.results.append(tagvalue)
        UserDefaults.standard.set(Manager.results, forKey: "saveData")
        isLikeBtnSelected = true
        }

    }
    
    func Apicall(){
        
        var todos = [Todo]()
        if Reachability.isConnectedToNetwork(){

        JsonHandler.StartRequest(HostURL, method: .get, params: nil , ShowIt: false, setview: self.view, success: { (Responce) in
              print(Responce)

            let jsonarray = Responce.arrayObject as NSArray?
            UserDefaults.standard.set(jsonarray, forKey: "jsonData")
            print(UserDefaults.standard.array(forKey: "jsonData")!)
            self.Postlist = Mapper<Todo>().mapArray(JSONArray: jsonarray as! [[String : Any]])
            
            self.tableview.reloadData()
            
          },EmptyData: { (Responce) in
           
          }) { (Error) in
           
              print("adfasdfsdfsdfsadfasdfsadfsdfd,.fd,.f,d.f,df")
          }
        }else{
            let jsonarray = UserDefaults.standard.array(forKey: "jsonData")!
            self.Postlist = Mapper<Todo>().mapArray(JSONArray: jsonarray as! [[String : Any]])
            self.tableview.reloadData()
        }
    }
    

}
extension PostListvc: UITableViewDataSource,UITableViewDelegate{
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Postlist.count
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Postlistcell", for: indexPath)  as! Postlistcell
    cell.Title_label.text = self.Postlist[indexPath.row].title
    cell.Description_label.text = self.Postlist[indexPath.row].body
    cell.Favbutton.tag = indexPath.row
    let ara = UserDefaults.standard.array(forKey: "saveData")

    if Manager.results.contains(indexPath.row) {
        cell.Favbutton.setImage(#imageLiteral(resourceName: "star_color"), for: .normal)

      //do something
    }else{
        cell.Favbutton.setImage(#imageLiteral(resourceName: "star_icon"), for: .normal)

    }
    return cell
}
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//          if let url = URL(string: self.Weburl_STRING[indexPath.row]) {
//          UIApplication.shared.open(url)
//}
    

}
}
