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
import SwiftyJSON
struct Manager {

static var results = [Int]()

}
class PostListvc: ViewController,UITableViewDelegate {
    var posts: [PostModel] = []

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        if let arr = UserDefaults.standard.array(forKey: "saveData") as? [Int]{
            Manager.results = arr
        }
        super.viewDidLoad()
        self.tableview.register(UINib(nibName: "Postlistcell", bundle: nil), forCellReuseIdentifier: "Postlistcell")
       
        apicallfun()
    }
    func apicallfun(){

        let client = APIClient.shared
         do{
           try client.getRecipes().subscribe(
            onNext: { [self] result in
              
                self.posts = result
                //MARK: display in UITableView
                DispatchQueue.main.async {
                    obdservertable()
                    
                }
                
             },
             onError: { error in
                print(error.localizedDescription)
             },
             onCompleted: {
             }).disposed(by: disposeBag)

           }
           catch{
         }
    }
    func obdservertable(){
        let items = Observable.just(posts)
        print(self.posts)
        items
            .bind(to: tableview.rx.items(cellIdentifier: "Postlistcell", cellType: Postlistcell.self)) { (row, element, cell) in
                cell.Title_label.text = element.getTitle()
                cell.Description_label.text = element.getBody()
                cell.Favbutton.tag = row
                if Manager.results.contains(row) {
                    cell.Favbutton.setImage(#imageLiteral(resourceName: "star_color"), for: .normal)
                }else{
                    cell.Favbutton.setImage(#imageLiteral(resourceName: "star_icon"), for: .normal)
                }
            }
            .disposed(by: disposeBag)

    }
}
