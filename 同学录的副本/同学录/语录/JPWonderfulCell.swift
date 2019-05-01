//
//  JPWonderfulCell.swift
//  同学录
//
//  Created by 姜澎 on 2019/4/29.
//  Copyright © 2019 jiangpeng. All rights reserved.
//

import UIKit

class JPWonderfulCell: UITableViewCell {

    @IBOutlet weak var conten: UILabel!
    
    var cont : String? {
        didSet {
            self.conten.text = cont 
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
