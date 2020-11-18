//
//  FavListvc.swift
//  Demoapp
//
//  Created by apple on 17/11/20.
//

import UIKit
import Alamofire
import ObjectMapper

class FavListvc: UIViewController {
    var Postlist:[PostlistModel] = []

    var isLikeBtnSelected = false
    var SaveArray : [Int] = []

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ///let array  = stringsarray?.compactMap({ Int($0 as! String) })
         Apicall()
        // Do any additional setup after loading the view.
    }
  
    @IBAction func Fvbutton_Tab(_ sender: UIButton) {
     

    }
    
    func Apicall(){
        print(SaveArray)
            let jsonarray = UserDefaults.standard.array(forKey: "jsonData")!
            self.Postlist = Mapper<PostlistModel>().mapArray(JSONArray: jsonarray as! [[String : Any]])
        
            self.tableview.reloadData()
    }
    

}
extension FavListvc: UITableViewDataSource,UITableViewDelegate{
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return Manager.results.count
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Postlistcell", for: indexPath)  as! Postlistcell
    let tagvalue = Manager.results[indexPath.row]
    cell.Title_label.text = self.Postlist[tagvalue].title
    cell.Description_label.text = self.Postlist[tagvalue].body
    cell.Favbutton.isHidden = true
    
    return cell
}
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//          if let url = URL(string: self.Weburl_STRING[indexPath.row]) {
//          UIApplication.shared.open(url)
//}
    

}
}

