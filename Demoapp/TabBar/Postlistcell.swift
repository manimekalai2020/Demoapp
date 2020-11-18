//
//  Postlistcell.swift
//  Demoapp
//
//  Created by apple on 17/11/20.
//

import UIKit

class Postlistcell: UITableViewCell {

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

}
