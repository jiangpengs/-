//
//  JPTecherCell.swift
//  同学录
//
//  Created by 姜澎 on 2019/4/28.
//  Copyright © 2019 jiangpeng. All rights reserved.
//

import UIKit

class JPTecherCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var tel: UILabel!
    
    var newModel : TecherModel? {
        didSet {
            self.name.text = newModel?.name
            self.subject.text = newModel?.subsject
            self.tel.text = newModel?.tel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
}
