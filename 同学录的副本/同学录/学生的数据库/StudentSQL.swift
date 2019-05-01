//
//  StudentSQL.swift
//  同学录
//
//  Created by 姜澎 on 2019/4/29.
//  Copyright © 2019 jiangpeng. All rights reserved.
//

import UIKit

let DBFILE_NAME_STU = "Student.db"

class StudentSQL: NSObject {
    
//  MARK:  句柄 (指针)
    private var db:OpaquePointer? = nil
    
    //  MARK:  sqlite存放位置
    private var plistFilePath: String!
    
    //  MARK:
    public static let sharedInstance : StudentSQL = {
        
        let instance = StudentSQL()
        
        //        设置sqlite存放位置
        instance.plistFilePath = instance.applicationDocumentsDirectoryFile()
        //        打开数据库建表
        instance.createEditableCopyOfDatabaseIfNeeded()
        
        return instance
        
    }()
    
    // MARK: stu的所有的路径
    private func applicationDocumentsDirectoryFile() -> String {
        
        //        拿到沙盒路径
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        
        //        stu的数据库
        let path = (documentDirectory[0] as AnyObject).appendingPathComponent(DBFILE_NAME_STU) as String
        
        return path
    }
    
    // MARK: 创建数据库建表
    private func createEditableCopyOfDatabaseIfNeeded() {
        
        let cpath = self.plistFilePath.cString(using: String.Encoding.utf8)
        
        //        打开数据库
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            NSLog("数据库打开失败。")
        } else {
            //            建表
            let sql = "CREATE TABLE IF NOT EXISTS Stu (name TEXT PRIMARY KEY, tel TEXT,emial TEXT, qq TEXT,text TEXT)"
            
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            if (sqlite3_exec(db,cSql!, nil, nil, nil) != SQLITE_OK) {
                NSLog("建表失败。")
            }
        }
        //        关闭数据
        sqlite3_close(db)
    }
    
    // MARK: 插入数据
    public func create(_ stu: StudentModel) -> Int {
        
        let cpath = self.plistFilePath.cString(using: String.Encoding.utf8)
        
        print(self.plistFilePath!)
        
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            NSLog("数据库打开失败。")
        } else {
            let sql = "INSERT OR REPLACE INTO Stu (name,tel,emial,qq,text) VALUES (?,?,?,?,?)"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            //语句对象
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                
                let name = stu.name?.cString(using: String.Encoding.utf8)
                let tel = stu.tel?.cString(using: String.Encoding.utf8)
                let emial = stu.emial?.cString(using: String.Encoding.utf8)
                let qq = stu.qq?.cString(using: String.Encoding.utf8)
                let text = stu.text?.cString(using: String.Encoding.utf8)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, name!, -1, nil)
                sqlite3_bind_text(statement, 2, tel!, -1, nil)
                sqlite3_bind_text(statement, 3, emial!, -1, nil)
                sqlite3_bind_text(statement, 4, qq!, -1, nil)
                sqlite3_bind_text(statement, 5, text!, -1, nil)
                
                
                //执行插入
                if sqlite3_step(statement) != SQLITE_DONE {
                    print("插入数据失败。")
                }
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(db)
        return 0
    }
    
    //  MARK:  查询所有数据
    public func findAll() -> NSMutableArray {
        
        let cpath = self.plistFilePath.cString(using: String.Encoding.utf8)
        
        let listData = NSMutableArray()
        
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            NSLog("数据库打开失败。")
        } else {
            let sql = "SELECT name,tel,emial,qq,text FROM Stu"
            
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            //语句对象
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                
                //执行查询
                while sqlite3_step(statement) == SQLITE_ROW {
                    
                    let stu = StudentModel()
                    
                    if let name = getColumnValue(index:0, stmt:statement!){
                        stu.name = name
                    }
                    if let tel = getColumnValue(index:1, stmt:statement!){
                        stu.tel = tel
                    }
                   
                    if let emial = getColumnValue(index:2, stmt:statement!){
                        stu.emial = emial
                    }
                    if let qq = getColumnValue(index:3, stmt:statement!){
                        stu.qq = qq
                    }
                    if let text = getColumnValue(index:4, stmt:statement!){
                        stu.text = text
                    }
                    
                    listData.add(stu)
                }
                
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(db)
        return listData
    }
    
    // MARK: 获得字段数据
    private func getColumnValue(index:CInt, stmt:OpaquePointer)->String? {
        
        if let ptr = UnsafeRawPointer.init(sqlite3_column_text(stmt, index)) {
            
            let uptr = ptr.bindMemory(to:CChar.self, capacity:0)
            
            let txt = String(validatingUTF8:uptr)
            
            return txt
        }
        return nil
    }
    
    //  MARK:  删除
    public func remove(_ stu: StudentModel) -> Int {
        
        let cpath = self.plistFilePath.cString(using: String.Encoding.utf8)
        
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            NSLog("数据库打开失败。")
        } else {
            let sql = "DELETE from Stu where name = ?"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            //语句对象
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                
                
                let n = stu.name
                let na = n?.cString(using: String.Encoding.utf8)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, na!, -1, nil)
                //执行删除数据
                if sqlite3_step(statement) != SQLITE_DONE {
                    NSLog("删除数据失败。")
                }
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(db)
        return 0
    }
    
    //    MARK: 修改
    public func modify(_ model: TecherModel) -> Int {
        
        let cpath = self.plistFilePath.cString(using: String.Encoding.utf8)
        
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            NSLog("数据库打开失败。")
        } else {
            let sql = "UPDATE Techers set name=?,set tel=?,set subject=?,set emial=?,set qq=?,set text=? where name =?,tel =?,subject =?,emial =?,emial =?,qq =?"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            //语句对象
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                
                let name = model.name
                let n = name!.cString(using: String.Encoding.utf8)
                
                
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, n!, -1, nil)
                
                
                //执行修改数据
                if sqlite3_step(statement) != SQLITE_DONE {
                    NSLog("修改数据失败。")
                }
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(db)
        return 0
    }
    
    
}


