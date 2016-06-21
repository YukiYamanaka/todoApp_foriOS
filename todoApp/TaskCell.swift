//
//  TableViewCellを継承したカスタムセルクラス
//
//  TaskCell.swift
//  todoApp
//
//  Created by Yuki on 2016/06/17.
//  Copyright © 2016年 yuki yamanaka. All rights reserved.
//
//通知元
import UIKit
import Alamofire
//1.プロトコルを定義
@objc protocol TaskCellDelegate {
    func loadTasks() -> Void
}

class TaskCell :UITableViewCell {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var status: UIButton!
    var id: Int!
    var url :String!
    //@IBOutlet weak var deleteBtn: UIButton!
    //3.デリゲートインスタンスを定義
    var delegate: TaskCellDelegate?
    
    func setCell(content :String, status :String, id: Int,url: String){
        self.content.text = content
        self.status.setTitle(status, forState: .Normal)
        self.id = id
        self.url = url
    }
    //セルのdeleteボタンが押された時
  func deleteTask(){
        //HTTP DELETE
        Alamofire.request(.DELETE, self.url)
            .responseString { JSON in
                print(JSON)
        //4.デリゲートメソッドの呼び出しを実装
        self.callLoadTasks()
     }
    }
    //2.デリゲートメソッドを定義
    func callLoadTasks(){
        //これでloadtasks呼べていない
        self.delegate?.loadTasks()
    }
   }
