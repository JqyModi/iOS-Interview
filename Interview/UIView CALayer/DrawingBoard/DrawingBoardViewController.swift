//
//  DrawingBoardViewController.swift
//  Interview
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class DrawingBoardViewController: UIViewController {
    
    //引用画板
    @IBOutlet weak var drawBoard: DrawingBoard!
    //方便设置默认选中绿色
    @IBOutlet weak var greenBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置默认选中绿色
        self.changeColor(self.greenBtn)
    }
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func clear(_ sender: UIBarButtonItem) {
        drawBoard.clear()
    }
    @IBAction func redo(_ sender: UIBarButtonItem) {
        drawBoard.redo()
    }
    @IBAction func rubber(_ sender: UIBarButtonItem) {
        drawBoard.rubber()
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
        drawBoard.save()
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
        //直接通过背景颜色来设置当前画笔颜色
        drawBoard.lineColor = sender.backgroundColor
    }
    
    @IBAction func changeWidth(_ sender: UISlider) {
        //设置线宽
        drawBoard.lineWidth = CGFloat(sender.value)
    }
}
