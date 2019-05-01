//
//  JPStudentTableview.swift
//  同学录
//
//  Created by 姜澎 on 2019/4/27.
//  Copyright © 2019 jiangpeng. All rights reserved.
//

import UIKit

class JPStudentTableview: UITableViewController {
    var listData = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = 150
        
        let dao = StudentSQL.sharedInstance
        
        self.listData = dao.findAll()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadView(_:)),
                                               name: Notification.Name(rawValue: "aaa"),
                                               object: nil)
        
        self.tableView.register(UINib(nibName: "JPStucell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    @objc func reloadView(_ notification : Notification) {
        
        let resList = notification.object as! NSMutableArray
        
        self.listData = resList
        
        self.tableView.reloadData()
        
    }


    
}

extension JPStudentTableview{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JPStucell
        let model = self.listData[indexPath.row] as! StudentModel
        cell.newModel = model
        return cell
    }
    //    自定义删除cell
    //    让cell成为删除状态
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //    让当前的cell可以编辑
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //        拿到cell对应的模型 传入数据库中
        let techer = self.listData[indexPath.row] as! StudentModel
        
        let s = StudentSQL.sharedInstance
        
        //        删除不用刷新，因为此方法自带刷新功能
        let _ = s.remove(techer)
        
        //        数据改变之后再查找所有的数据从新赋值
        self.listData = s.findAll()
        
        self.tableView .deleteRows(at: [indexPath], with: .fade)
    }
    //    cell 选中操作
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let t = self.listData[indexPath.row] as! StudentModel
        
        let look = JPStuLookVC()
        //        顺传值
        look.teacher = t
        
        self.navigationController?.pushViewController(look, animated: true)
        
//        添加 删除 查看 修改 搜索
    }
}
