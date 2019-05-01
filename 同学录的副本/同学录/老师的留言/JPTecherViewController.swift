//
//  JPTecherViewController.swift
//  同学录
//
//  Created by 姜澎 on 2019/4/27.
//  Copyright © 2019 jiangpeng. All rights reserved.
//

import UIKit

class JPTecherViewController: UIViewController {
//    MARK 属性
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var qq: UITextField!
    @IBOutlet weak var emial: UITextField!
    
    @IBOutlet weak var text: UITextView!
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func tijiao(_ sender: Any) {
        
        let t = TecherModel()
        t.name = self.name.text
        t.tel = self.tel.text
        t.subsject = self.subject.text
        t.qq = self.qq.text
        t.emial = self.emial.text
        t.text = self.text.text
        
//        插入数据
        let _  = SQLManager.sharedInstance.create(t)
//       查找所有数据
        let reslist = SQLManager.sharedInstance.findAll()
//        发布通知
        NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadViewNotification"), object: reslist, userInfo: nil)
        
    }
    
   
    
}
