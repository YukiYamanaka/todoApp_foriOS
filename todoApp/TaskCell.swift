//
//  TableViewCellを継承したカスタムセルクラス
//
//  TaskCell.swift
//  todoApp
//
//  Created by Yuki on 2016/06/17.
//  Copyright © 2016年 yuki yamanaka. All rights reserved.
//
//通知先
import UIKit
import Alamofire

//1.プロトコルを定義
@objc protocol TaskDelegate {
    func loadTasks() -> Void
}

//1.プロトコルに準拠
class TaskCell :UITableViewCell {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var status: UIButton!
    var id: Int!
    var url :String!
    //@IBOutlet weak var deleteBtn: UIButton!
    var delegate :TaskDelegate?
    
    func setCell(content :String, status :String, id: Int,url: String){
        self.content.text = content
        self.status.setTitle(status, forState: .Normal)
        self.id = id
        self.url = url
        //2.委託元viewControllerクラスのデリゲートを委託先(self)にセット
           }
    //セルのdeleteボタンが押された時
  func deleteTask(){
        //HTTP DELETE
        Alamofire.request(.DELETE, self.url)
            .responseString { JSON in
                print(JSON)
        }
    self.delegate?.loadTasks()
    }

   }
