//
//  JPStudentVC.swift
//  同学录
//
//  Created by 姜澎 on 2019/4/28.
//  Copyright © 2019 jiangpeng. All rights reserved.
//

import UIKit

class JPStudentVC: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var emial: UITextField!
    @IBOutlet weak var qq: UITextField!
    @IBOutlet weak var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.delegate = self
        self.tel.delegate = self
        self.emial.delegate = self
        self.qq.delegate = self
        self.text.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return  true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n"){
            self.text.endEditing(true)
            return false
        }
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.name.resignFirstResponder()
    }
    
    @IBAction func tijiao(_ sender: Any) {
        
        let t = StudentModel()
        t.name = self.name.text
        t.tel = self.tel.text
        t.qq = self.qq.text
        t.emial = self.emial.text
        t.text = self.text.text
        
        //        插入数据
        let _  = StudentSQL.sharedInstance.create(t)
        //       查找所有数据
        let reslist = StudentSQL.sharedInstance.findAll()
        //        发布通知
        NotificationCenter.default.post(name: Notification.Name(rawValue: "aaa"), object: reslist, userInfo: nil)
    }
    
  

}
