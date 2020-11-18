//
//  Homeviewcontroller.swift
//  Demoapp
//
//  Created by apple on 17/11/20.
//

import UIKit

class Homeviewcontroller: UIViewController {
    var pageMenue: CAPSPageMenu?
    open weak var delegate : CAPSPageMenuDelegate?
    @IBOutlet weak var BgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
initialSetup()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Homeviewcontroller{
    
    private func initialSetup(){
        
        
        self.setupPageMenu()
        
    }
    
    private func setupPageMenu(){
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        //        let controller1 : FollowListVC = FollowListVC.instantiate(fromAppStoryboard: .Home)
        let controller1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostListvc") as? PostListvc
        controller1!.title = "Posts"
        
      //  controller1.delegate = self
        controllerArray.append(controller1!)
        
        let controller2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavListvc") as? FavListvc
        controller2!.title = "Favourite"
               // controller2.delegate = self
        controllerArray.append(controller2!)
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor.lightGray),
            .selectionIndicatorColor(UIColor.red),
            .addBottomMenuHairline(true),
            .bottomMenuHairlineColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),
            .menuItemFont(UIFont(name: "HelveticaNeue-Bold", size: 15.0)!),
            .menuHeight(40),
            .menuItemWidth(self.view.frame.width/2.5),
            .selectionIndicatorHeight(2.0),
            .menuItemWidthBasedOnTitleTextWidth(false),
            .selectedMenuItemLabelColor(UIColor.black)
        ]
        
        pageMenue = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)

        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.BgView.addSubview(pageMenue!.view)

    }
}
extension Homeviewcontroller: CAPSPageMenuDelegate{
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
       
    }
}
