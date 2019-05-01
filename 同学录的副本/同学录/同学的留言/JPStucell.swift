//
//  JPStucell.swift
//  同学录
//
//  Created by 姜澎 on 2019/4/29.
//  Copyright © 2019 jiangpeng. All rights reserved.
//

import UIKit

class JPStucell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tel: UILabel!
    
    var newModel : StudentModel? {
        didSet {
            self.name.text = newModel?.name
            
            self.tel.text = newModel?.tel
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
