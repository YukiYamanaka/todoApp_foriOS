//
//  ViewController.swift
//  todoApp
//
//  Created by Yuki on 2016/06/17.
//  Copyright © 2016年 yuki yamanaka. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var table :UITableView! //TableView
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var taskArray = NSArray() //JSONで取得したtask一覧を格納する変数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TableViewの参照先
        table.dataSource = self
        table.delegate = self
        
        self.loadTasks()
            }
       //テーブルビューのセルの数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    //セルの表示内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let taskDic = taskArray[indexPath.row] as! NSDictionary
        let content = taskDic["content"] as? String
        let status = taskDic["status"] as? String
        let id = taskDic["id"] as? Int
        let url = taskDic["url"] as? String
        let cell :TaskCell  = tableView.dequeueReusableCellWithIdentifier("TaskCell")! as! TaskCell
        cell.setCell(content!, status: status!, id: id!, url: url!)
        return cell
    }
    //セルがタップされた時の処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //タップされたセルのインデックス番号を出力
        print("tapped cell:\(indexPath.row)")
        print(taskArray[indexPath.row])
    }
    //tableViewの表示更新,task一覧のGETリクエスト
    func loadTasks(){
        let requestUrl = "http://wdp4.com/tasks.json"
        //HTTPリクエスト
        Alamofire.request(.GET, requestUrl).responseJSON { response in
            switch response.result {
            case.Success(let json):
                //JSONを辞書のデータ型にパース
                self.taskArray = json as! NSArray
                print(self.taskArray)
                //テーブルビューに表示
                self.table.reloadData()
                
            case.Failure(let error):
                print("通信エラー:\(error)")
            }
        }
        
    }

    //新規task登録ボタンが押された時
    @IBAction func addTapped(){
    //taxtFieldがnilでなければHTTPリクエストを送信
        if self.textField.text != nil {
            let addReqUrl = "http://192.168.80.10:3000/tasks"
            let newContent :String = self.textField.text!
            //let lastTaskId = self.taskArray.lastObject!["id"] as! Int
            let params = [ "content" :newContent,
                           "status" :"todo",
                        //   "id" :lastTaskId+1 ,
                 ]
            Alamofire.request(.POST, addReqUrl, parameters: params, encoding: .JSON)
                    .responseString {JSON in
                        print(JSON)
                        //リスト再取得
                        self.loadTasks()
            }
        }
    }
    //セルのstatusボタンがタップされた時
    @IBAction func statusTapped(){
        //todo,doing,doneの選択肢を表示
        //statusが変更されればonChangeStatus
    }
    //セルのstatusが変更された時
    func onChangeStatus(){
        //HTTP POSTで変更を送信
        //再取得
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

