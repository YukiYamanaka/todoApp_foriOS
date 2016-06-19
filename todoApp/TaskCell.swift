//
//  TableViewCellを継承したカスタムセルクラス
//
//  TaskCell.swift
//  todoApp
//
//  Created by Yuki on 2016/06/17.
//  Copyright © 2016年 yuki yamanaka. All rights reserved.
//

import UIKit
import Alamofire
class TaskCell :UITableViewCell {
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var status: UIButton!
    var id: Int!
    var url :String!
    @IBOutlet weak var deleteBtn: UIButton!
    
    func setCell(content :String, status :String, id: Int,url: String){
        self.content.text = content
        self.status.setTitle(status, forState: .Normal)
        self.id = id
        self.url = url
    }
    //セルのdeleteボタンが押された時
    @IBAction func deleteTapped(){
        //HTTP DELETE
        Alamofire.request(.DELETE, self.url)
            .responseString { JSON in
                print(JSON)
                ViewController.loadTasks()
        //再取得
    }
    }
   }
