//
//  Friend.swift
//  Interview
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 modi. All rights reserved.
//

import Foundation
class Friend: NSObject {
    @objc var nick: String?
    @objc var qm: String?
    @objc var icon: String?
    
    
    init(dict: [String : Any]?) {
        super.init()
        if (dict != nil) {
            self.setValuesForKeys(dict!)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
