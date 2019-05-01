//
//  UITecherTableViewContrller.swift
//  同学录
//
//  Created by 姜澎 on 2019/4/27.
//  Copyright © 2019 jiangpeng. All rights reserved.
//

import UIKit


class UITecherTableViewContrller: UITableViewController{

    //    MARK:属性
    var listData = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        去掉tableview下划线
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//       这里是控制器启动时加载数据
        //获得DAO对象
        let dao = SQLManager.sharedInstance
        //查询所有数据
        self.listData = dao.findAll()
//        注册cell
        self.tableView.register(UINib(nibName: "JPTecherCell", bundle: nil), forCellReuseIdentifier: "JPTeacherCell")
        
        self.tableView.rowHeight = 150
//        接收通知
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadView(_:)),
                                                   name: Notification.Name(rawValue: "reloadViewNotification"),
                                                 object: nil)

    }
    
    // MARK: --处理通知  这里是添加完成时加载数据
    @objc func reloadView(_ notification : Notification) {
        
        let resList = notification.object as! NSMutableArray
        
        self.listData = resList
        
        self.tableView.reloadData()
        
    }
    

    
    

}

//代理协议方法
extension UITecherTableViewContrller{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JPTeacherCell", for: indexPath) as! JPTecherCell
        
//        去掉选中灰色
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        
        let techer = self.listData[indexPath.row] as! TecherModel
        
        cell.newModel = techer
        
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

//    删除操作
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        拿到cell对应的模型 传入数据库中
        let techer = self.listData[indexPath.row] as! TecherModel
        
        let s = SQLManager.sharedInstance
        
//        删除不用刷新，因为此方法自带刷新功能
        let _ = s.remove(techer)
        
//        数据改变之后再查找所有的数据从新赋值
        self.listData = s.findAll()
        
        self.tableView .deleteRows(at: [indexPath], with: .fade)
    }
    
//    cell 选中操作
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let t = self.listData[indexPath.row] as! TecherModel
        
        let look = JPLookVC()
//        顺传值
        look.teacher = t
        
        self.navigationController?.pushViewController(look, animated: true)
        
        
    }
    
    
    
  
    
}
