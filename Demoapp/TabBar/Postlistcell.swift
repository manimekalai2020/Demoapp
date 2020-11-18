//
//  Postlistcell.swift
//  Demoapp
//
//  Created by apple on 17/11/20.
//

import UIKit

class Postlistcell: UITableViewCell {
    var isLikeBtnSelected = false

    @IBOutlet weak var Title_label: UILabel!
    @IBOutlet weak var Description_label: UILabel!
    @IBOutlet weak var Favbutton: UIButton!
    
    @IBOutlet weak var Readmore_button: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
}
