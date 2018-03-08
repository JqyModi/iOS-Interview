//
//  BarView.swift
//  Interview
//
//  Created by mac on 2018/3/8.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class BarView: UIView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        //获取上下文对象：layer类型上下文
        let context = UIGraphicsGetCurrentContext()
        let array: Array<CGFloat> = [0.1, 0.3, 0.5, 0.3, 0.2, 0.7,0.9]
        getBarViewWithArray(array: array)
    }
    
    private func getBarViewWithArray(array: [CGFloat]) {
        let count = array.count
        
        for var i in (0..<count) {
            let spaceWidth = 10
            let width = (self.bounds.size.width - CGFloat((count-1)*spaceWidth)) / CGFloat(count)
            let height = self.bounds.size.height * array[i]
            let x: CGFloat = (width + CGFloat(spaceWidth)) * CGFloat(i)
            let y: CGFloat = self.bounds.size.height - height
            let rect = CGRect(x: x, y: y, width: width, height: height)
            let path = UIBezierPath(rect: rect)
            //设置样式
            getRandomColor().set()
            path.lineWidth = 1
            path.fill()
        }
    }

    private func getRandomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1)
    }
}
