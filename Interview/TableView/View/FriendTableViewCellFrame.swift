//
//  FriendTableViewCellFrame.swift
//  Interview
//
//  Created by mac on 2018/3/2.
//  Copyright © 2018年 modi. All rights reserved.
//

import Foundation
import CoreGraphics

class FriendTableViewCellFrame: NSObject {
    
    var model: Group? {
        didSet {
            calcFrames()
        }
    }
    
    //private 不希望别人能够更改
    private var iconFrame: CGRect?
    private var titleLabelFrame: CGRect?
    private var textLabelFrame: CGRect?
    private var answerLabelFrame: CGRect?
    private var rowHeight: CGFloat = 0.0
    
    private func calcFrames() {
        let margin: CGFloat = 10
        //通过数据模型计算好每个子控件的Frame
        //self.iconFrame = ...
        //self.titleLabelFrame = ...
        //self.textLabelFrame = ...
        //self.answerLabelFrame = ...
        //...
        //通过最底部子控件计算出rowHeight
        self.rowHeight = (answerLabelFrame?.maxY)! + margin
    }
}
