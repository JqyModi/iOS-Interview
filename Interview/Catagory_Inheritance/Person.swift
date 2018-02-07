//
//  Person.swift
//  Interview
//
//  Created by mac on 2018/1/26.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class Person: NSObject {
    private var name: String?
    private var age: String?
    
    init(name: String, age: String) {
        self.name = name
        self.age = age
    }
    
    public func printNameAndAge() {
        debugPrint("name = \(name) \r\n age = \(age)")
    }
    
    public func checkTitleWithAge(age: String) {
        if age == "12" {
            debugPrint("头衔：小学生")
        }
        if age == "22" {
            debugPrint("头衔：青年")
        }
        if age == "32" {
            debugPrint("头衔：中年")
        }
    }
    
    //泛型
    
    
}
