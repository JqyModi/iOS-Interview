//
//  ViewController.swift
//  Interview
//
//  Created by mac on 2018/1/26.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var test: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let p = Person(name: "SaoBing", age: "12")
        p.checkTitleWithAge(age: "12")
        
        UIImageView().image = UIImage(named: "activity")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        test2()
        debugPrint("touchesBegan >>> \(self.classForCoder)")
        super.touchesBegan(touches, with: event)
        
        //测试SEL
        testSelector()
    }
    
    @objc private func test1() {
        var immutableArr = Array<String>()
        debugPrint(unsafeBitCast(immutableArr, to: UnsafeRawPointer.self))
//        debugPrint("im1 = \(immutableArr)")
        immutableArr.append("hello")
        debugPrint(unsafeBitCast(immutableArr, to: UnsafeRawPointer.self))
//        debugPrint("im2 = \(immutableArr)")
        immutableArr.append("hello1")
        debugPrint(unsafeBitCast(immutableArr, to: UnsafeRawPointer.self))
    }
    
    @objc private func test2() {
        let immutableArr = NSMutableArray()
//        debugPrint(unsafeBitCast(immutableArr, to: UnsafeRawPointer.self))
        debugPrint(Unmanaged.passUnretained(immutableArr).toOpaque())
        immutableArr.add("hello")
//        debugPrint(unsafeBitCast(immutableArr, to: UnsafeRawPointer.self))
        debugPrint(Unmanaged.passUnretained(immutableArr).toOpaque())
        immutableArr.add("hello1")
//        debugPrint(unsafeBitCast(immutableArr, to: UnsafeRawPointer.self))
        debugPrint(Unmanaged.passUnretained(immutableArr).toOpaque())
        
    }
    
    private func testSelector() {
        //通过方法名字符串创建一个SEL(Selector)对象
        let sel = Selector.init("test2")
//        perform(sel)
        
        //断言测试
//        assert(sel == nil, "断言生效 ~ ····")
        
        let sel2 = Selector.init(stringLiteral: "test1")
        perform(sel2)
    
        //对比原方法地址与SEL对象地址
        debugPrint("sel ----> \(unsafeBitCast(sel, to: UnsafeRawPointer.self))")
        
        //判断当前类是否实现了某个方法
        let isExist = self.responds(to: "test2")
    }
    
}

