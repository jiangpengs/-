//
//  JPLookVC.swift
//  同学录
//
//  Created by 姜澎 on 2019/4/29.
//  Copyright © 2019 jiangpeng. All rights reserved.
//

import UIKit
import SnapKit



class JPLookVC: UIViewController{
    
//    顺传的属性
    var teacher:TecherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let imageView = UIImageView()
        
        let image = UIImage(named: "backgroundImage")
        
        imageView.image = image
        
        self.view.addSubview(imageView)
// 姓名
        let nameLabel = UILabel()
        
        nameLabel.text = "姓名:"
        
        self.view.addSubview(nameLabel)
// 名字
        let name = UILabel()
        
        name.text = self.teacher?.name! ?? "...."
        
        self.view.addSubview(name)
// 电话
        let tel = UILabel()
        
        tel.text = "电话:"
        
        self.view.addSubview(tel)
// 电话号
        let number = UILabel()
        
        number.text = self.teacher?.tel! ?? "...."
        
        self.view.addSubview(number)
        
//  学科
        let sub = UILabel()
        
        sub.text = "学科:"
        
        self.view.addSubview(sub)
        
//   学科名
        let subject  = UILabel()
        
        subject.text = teacher?.subsject! ?? "..."
        
        self.view.addSubview(subject)
//    qq
        let qq  = UILabel()
        
        qq.text = "QQ:"
        
        self.view.addSubview(qq)
        
//    qq号
        let qqnumber  = UILabel()
        
        qqnumber.text = teacher?.qq! ?? "..."
        
        self.view.addSubview(qqnumber)
//    邮箱
        let emial  = UILabel()
        
        emial.text = "邮箱:"
        
        self.view.addSubview(emial)
        
//     邮箱号
        let emilaNumber  = UILabel()
        
        emilaNumber.text = teacher?.emial! ?? "..."
        
        self.view.addSubview(emilaNumber)
        
//        评价
        let talk = UILabel()
        
        talk.text = "评价:"
        
        self.view.addSubview(talk)
        
//        内容
        let talkTest = UILabel()
        
        talkTest.text = teacher?.text! ?? "...."
        
        self.view.addSubview(talkTest)
        
//        UILable 不设置宽高就是自适应
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.top.equalTo(100)
        }
        
        name.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp_right).offset(10)
            make.top.equalTo(nameLabel.snp_top)
        }
        
        tel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp_left)
            make.top.equalTo(nameLabel.snp_bottom).offset(20)
        }
        
        number.snp_makeConstraints { (make) in
            make.top.equalTo(tel.snp_top)
            make.left.equalTo(tel.snp_right).offset(10)
        }
        
        sub.snp_makeConstraints { (make) in
            make.left.equalTo(tel.snp_left)
            make.top.equalTo(tel.snp_bottom).offset(20)
        }
        
        subject.snp_makeConstraints { (make) in
            make.top.equalTo(sub.snp_top)
            make.left.equalTo(sub.snp_right).offset(10)
        }
        
        qq.snp_makeConstraints { (make) in
            make.left.equalTo(sub.snp_left)
            make.top.equalTo(sub.snp_bottom).offset(20)
        }
        
        qqnumber.snp_makeConstraints { (make) in
            make.top.equalTo(qq.snp_top)
            make.left.equalTo(qq.snp_right).offset(10)
        }
        
        emial.snp_makeConstraints { (make) in
            make.left.equalTo(qq.snp_left)
            make.top.equalTo(qq.snp_bottom).offset(20)
        }
        
        emilaNumber.snp_makeConstraints { (make) in
            make.top.equalTo(emial.snp_top)
            make.left.equalTo(emial.snp_right).offset(10)
        }
        
        talk.snp_makeConstraints { (make) in
            make.left.equalTo(emial.snp_left)
            make.top.equalTo(emial.snp_bottom).offset(20)
        }
        
        talkTest.snp_makeConstraints { (make) in
            make.top.equalTo(talk.snp_bottom).offset(20)
            make.left.equalTo(50)
            make.right.equalTo(20)
        }
        
        imageView.snp_makeConstraints { (make) in
            make.top.equalToSuperview().offset(64)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-64)
        }
    }
    
   
    deinit {
//        print(self,"fream")
    }

}
