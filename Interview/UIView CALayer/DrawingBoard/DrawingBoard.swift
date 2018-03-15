//
//  DrawingBoard.swift
//  Interview
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class DrawingBoard: UIView {

    var lineWidth: CGFloat = 5
    var lineColor: UIColor?
    
    //绘制多条路径用一个数组来记录
    lazy var paths: [DrawBoardPath]? = {
        let paths = NSMutableArray()
        return paths as! [DrawBoardPath]
    }()
    
    override func draw(_ rect: CGRect) {
        // 画线
        
        for path in paths! {
            //设置画笔颜色
            path.lineColor?.set()
            path.stroke()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //创建路径
        let path = DrawBoardPath()
        
        //设置每条线线宽
        path.lineWidth = self.lineWidth
        //通过自定义一个来新增属性来记录每条路径不同颜色
        path.lineColor = self.lineColor
        //不能再draw外部设置颜色
//        self.lineColor?.set()
        //设置线头及连接处样式
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        
        //添加到数组中
        paths?.append(path)
        
        //获取手指触摸的点坐标
        let p = touches.first?.location(in: self)
        path.move(to: p!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //连接路径
        //获取手指触摸的点坐标
        let p = touches.first?.location(in: self)
        //获取数组中最后一条路径
        paths?.last?.addLine(to: p!)
        
        //重绘界面
        self.setNeedsDisplay()
    }
    
    //MARK: - 工具条功能实现
    //清屏
    func clear() {
        //清空所有路径重绘
        self.paths?.removeAll()
        self.setNeedsDisplay()
    }
    //回退
    func redo() {
        //清空最后一条路径重绘
        self.paths?.removeLast()
        self.setNeedsDisplay()
    }
    //橡皮
    func rubber() {
        //将画笔改成跟背景色一致
        self.lineColor = self.backgroundColor
    }
    //保存到相册
    func save() {
        //截图保存到相册
        getAndSaveScreenshotOfView(view: self)
    }
    
    private func getAndSaveScreenshotOfView(view: UIView) -> UIImage {
        //开启图片上下文
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        //获取当前上下文
        let context = UIGraphicsGetCurrentContext()
        //获取屏幕截图
        self.layer.render(in: context!)
        //获取上下文中渲染好的图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //关闭图片上下文
        UIGraphicsEndImageContext()
        //将图片保存到相册：需要加描述信息告知用户:已经添加
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        return image!
    }

}
