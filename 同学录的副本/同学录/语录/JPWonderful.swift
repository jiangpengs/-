//
//  JPWonderful.swift
//  同学录
//
//  Created by 姜澎 on 2019/4/29.
//  Copyright © 2019 jiangpeng. All rights reserved.
//

import UIKit

class JPWonderful: UITableViewController {
    var array:[String] = [String]()
    
    
    @IBOutlet weak var jpcell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.register(UINib(nibName:"JPWonderfulCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = 100
        
        array =  [
            "愿我如星君如月，夜夜流光相皎洁。",
            "无限山河泪，谁言天地宽！",
            "可怜人意，薄于云水，佳会更难重。",
         "谁言千里自今夕，离梦杳如关塞长。",
            "十年离乱后，长大一相逢。",
            "曾经沧海难为水，除却巫山不是云。",
            "故人西辞黄鹤楼，烟花三月下扬州。",
            "海内存知己，天涯若比邻",
            "劝君更尽一杯酒，西出阳关无故人。",
            "洛阳亲友如相问，一片冰心在玉壶",
            "相见时难别亦难，东风无力百花残。。",
            "莫愁前路无知己，天下谁人不识君",
            "接天莲叶无穷碧，映日荷花别样红。",
            "孤帆远影碧空尽，唯见长江天际流。",
            "离离原上草，一岁一枯荣。",
            "粗缯大布裹生涯，腹有诗书气自华。"
        ]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JPWonderfulCell

        let a = self.array[indexPath.row]
    
//        cell.textLabel?.text = a
        cell.cont = a
        
        return cell
    }
 

}
