//
//  Group.swift
//  Interview
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 modi. All rights reserved.
//

import Foundation

class Group: NSObject {
    @objc var name: String?
    @objc var online: Int = 0
    @objc var friends: Array<Any>?
    
    @objc var isVisiable = false
    
    init(dict: [String : Any]?) {
        super.init()
        
        if (dict != nil) {
            
        
            self.setValuesForKeys(dict!)
            
            //取出数据封装到模型中
            var arr = NSMutableArray()
            for item in self.friends! {
                let friend = Friend(dict: item as! [String : Any])
                arr.add(friend)
            }
            self.friends = arr as! Array<Any>
            
            debugPrint(self.friends)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
