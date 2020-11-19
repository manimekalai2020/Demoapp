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

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Apicall()
    }
    @IBAction func Fvbutton_Tab(_ sender: UIButton) {
    }
    func Apicall(){
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

}
}


