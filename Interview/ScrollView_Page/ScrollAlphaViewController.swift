//
//  ScrollAlphaViewController.swift
//  Interview
//
//  Created by mac on 2018/2/26.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class ScrollAlphaViewController: UIViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var p2: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置contentsize保证scrollView能滚动
        scrollview.contentSize = CGSize(width: p2.frame.maxX, height: p2.frame.maxY)
        //设置contentOffset使contentView与scrollView 一开始就有一定距离
        scrollview.contentOffset = CGPoint(x: 0, y: -(topView.bounds.height - UIApplication.shared.statusBarFrame.height))
        //设置contentInset使contentView与scrollView始终保持多少距离
        scrollview.contentInset = UIEdgeInsets(top: (topView.bounds.height - UIApplication.shared.statusBarFrame.height), left: 0, bottom: bottomView.bounds.height + 8, right: 0)
        //设置是否可用缩放
//        scrollview.minimumZoomScale = 1.0
//        scrollview.maximumZoomScale = 2.0
        //设置scrollView隐藏滚动条
        scrollview.showsVerticalScrollIndicator = false
    }

}
