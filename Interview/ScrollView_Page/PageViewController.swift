//
//  PageViewController.swift
//  Interview
//
//  Created by mac on 2018/2/26.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var lastImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //添加记录page的索引
//    private var index = 0
    //引用计时器作为全局属性: 计时器一旦停止就废了不能再重用了
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置scrollView的contentsize保证能滚动
        scrollview.contentSize = CGSize(width: lastImage.frame.maxX, height: 0)
//        scrollview.setContentOffset(CGPoint(x: 8, y: 0), animated: true)
        //去掉滚动条
        scrollview.showsHorizontalScrollIndicator = false
        //设置分页效果
        scrollview.isPagingEnabled = true
        //设置是否可用缩放
        scrollview.minimumZoomScale = 1.0
        scrollview.maximumZoomScale = 2.0
        
        //设置scrollView的代理
        scrollview.delegate = self
        
        //创建定时器：
        //方式1.创建的定时器会自动运行：滚动到下一页
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            debugPrint("func --> \(#function) : line --> \(#line)")
            self.scroll()
        }
        //方式2.创建的定时器需要加到RunLoop中才能自动运行 || 不添加到RunLoop中则需要手动调用.fire()来一次一次运行
//        let timer = Timer(timeInterval: 1.0, repeats: true) { (timer) in
//            debugPrint("func --> \(#function) : line --> \(#line)")
//        }
//        //将Timer添加到RunLoop中自动执行
//        let runloop = RunLoop.current
//        runloop.add(timer, forMode: RunLoopMode.commonModes)
        
//        //方式3.CADisplayLink(当定时时间间隔小于1秒时使用)
//        let dl = CADisplayLink(target: self, selector: "scroll")
//        dl.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        
        // * bug：由于UI控件的优先级比定时器Timer的优先级高所有当遇到UI控件上也有耗时操作时就会阻塞Timer的执行
        //1.设置Timer的优先级与UI控件的优先级一样
        //1.1通过RunLoop对象设置当前Timer优先级：也就是RunLoop的运行模式
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }

    /**
     *  Desc: 滚动到下一页
     *  Param:
     */
    private func scroll() {
        //1.获取当前的页码：
        var page = self.pageControl.currentPage
        //2.判断是否滚动到最后一页
        if page == self.pageControl.numberOfPages - 1 {
            page = 0
        }else {
            page = page + 1
        }
        //3.通过当前page计算出scrollView偏移量来控制移动到下一页操作
        var offsetX = self.scrollview.contentOffset.x
        offsetX = CGFloat(page) * CGFloat(self.scrollview.frame.width)
        //4.设置scrollView的contentOffset
        self.scrollview.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

extension PageViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        debugPrint("func --> \(#function) : line --> \(#line)")
        //1.解决当拖拽scrollView时轮播图中定时器一直运行导致后面两张轮播图快速跳转bug
        //1.1停止计时器:invalidate：无效
        timer?.invalidate()
        //1.2计时器一旦停止就废了不能再重用了
        timer = nil
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        debugPrint("func --> \(#function) : line --> \(#line)")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        debugPrint("func --> \(#function) : line --> \(#line)")
        //2.解决当拖拽scrollView时轮播图中定时器一直运行导致后面两张轮播图快速跳转bug
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            debugPrint("func --> \(#function) : line --> \(#line)")
            self.scroll()
        }
        
        // * bug：由于UI控件的优先级比定时器Timer的优先级高所有当遇到UI控件上也有耗时操作时就会阻塞Timer的执行
        //1.设置Timer的优先级与UI控件的优先级一样
        //1.1通过RunLoop对象设置当前Timer优先级：也就是RunLoop的运行模式
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    //减速
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        debugPrint("func --> \(#function) : line --> \(#line)")
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        debugPrint("func --> \(#function) : line --> \(#line)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        debugPrint("func --> \(#function) : line --> \(#line)")
        //计算当前页码并设置给pageControl(+ scrollView.frame.width * 0.5 : 表示当我们滚动超过一半就跳到第二页)
        let offsetX = scrollView.contentOffset.x + scrollView.frame.width * 0.5
        //计算当前页码
        let index = Int(offsetX / lastImage.bounds.width)
        //设置页码给pageControl
        pageControl.currentPage = index
    
    }
}
