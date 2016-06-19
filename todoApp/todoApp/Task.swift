//
//  TableViewCellをカスタムするためのデータ型
//
//  Task.swift
//  todoApp
//
//  Created by Yuki on 2016/06/17.
//  Copyright © 2016年 yuki yamanaka. All rights reserved.
//

import Foundation
class Task :NSObject {
    var content :String
    var status :String
    var id :Int
    
    init(content:String, status:String, id:Int){
        self.content = content
        self.status = status
        self.id = id
    }
}
