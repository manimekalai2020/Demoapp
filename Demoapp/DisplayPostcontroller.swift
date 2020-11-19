import UIKit
import RxSwift
import RxCocoa
class DisplayPostcontroller: UIViewController {
  var posts: [PostModel] = []
  let disposeBag = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let client = APIClient.shared
    do{
      try client.getRecipes().subscribe(
        onNext: { result in
           self.posts = result
           //MARK: display in UITableView
        },
        onError: { error in
           print(error.localizedDescription)
        },
        onCompleted: {
           print("Completed event.")
        }).disposed(by: disposeBag)
      }
      catch{
    }
  }
}
