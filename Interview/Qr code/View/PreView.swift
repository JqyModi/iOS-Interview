//
//  PreView.swift
//  Interview
//
//  Created by mac on 2018/3/22.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit
import AVFoundation

/**
 *  Desc: 自定义一个扫描时View
 *  Param:
 */
class PreView: UIView {
    
    var imageView: UIImageView?
    var lineImageView: UIImageView?
    var timer: Timer?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *  layer的类型
     *
     *  @return AVCaptureVideoPreviewLayer 特殊的layer 可以展示输入设备采集到得信息
     */
//    + (Class)layerClass
//    {
//    return [AVCaptureVideoPreviewLayer class];
//    }
    
    //重写父类的layerClass返回自己需要的类型：向下转型
    override class var layerClass: AnyClass {
//        return CAGradientLayer.self
        return AVCaptureVideoPreviewLayer.self
    }
    
//    - (void)setSession:(AVCaptureSession *)session
//    {
//    _session = session;
//
//    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)  self.layer;
//    layer.session = session;
//    }
    
    //接收需要设置到AVCaptureVideoPreviewLayer的Session
    var session: AVCaptureSession? {
        didSet {
            let l: AVCaptureVideoPreviewLayer = self.layer as! AVCaptureVideoPreviewLayer
            l.session = self.session
        }
    }

//    - (instancetype)initWithFrame:(CGRect)frame
//    {
//    if (self = [super initWithFrame:frame]) {
//    [self initUiConfig];
//    }
//    return self;
//    }
    
    //初始化时添加扫描UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUIConfig()
    }

//    - (void)initUiConfig
//    {
//    //设置背景图片
//    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg.png"]];
//    //设置位置到界面的中间
//    _imageView.frame = CGRectMake(self.bounds.size.width * 0.5 - 140, self.bounds.size.height * 0.5 - 140, 280, 280);
//    //添加到视图上
//    [self addSubview:_imageView];
//
//    //初始化二维码的扫描线的位置
//    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
//    _lineImageView.image = [UIImage imageNamed:@"line.png"];
//    [_imageView addSubview:_lineImageView];
//
//    //开启定时器
//    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animation) userInfo:nil repeats:YES];
//    }
    
    //添加扫描框+扫描线
    private func initUIConfig() {
        self.imageView = UIImageView(image: UIImage(named: "pick_bg.png"))
        self.imageView?.frame = CGRect(x: self.bounds.size.width * 0.5 - 140, y: self.bounds.size.height * 0.5 - 140, width: 280, height: 280)
        self.addSubview(imageView!)
        lineImageView = UIImageView(image: UIImage(named: "line.png"))
        imageView?.addSubview(lineImageView!)
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.animation), userInfo: nil, repeats: true)
    }
    
//    - (void)animation
//    {
//    [UIView animateWithDuration:2.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//
//    _lineImageView.frame = CGRectMake(30, 260, 220, 2);
//
//    } completion:^(BOOL finished) {
//    _lineImageView.frame = CGRectMake(30, 10, 220, 2);
//    }];
//    }
    
    //添加扫描线动画
    @objc private func animation() {
        UIView.animate(withDuration: 3, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.lineImageView?.frame = CGRect(x: 30, y: 260, width: 220, height: 2)
        }) { (finished) in
            self.lineImageView?.frame = CGRect(x: 30, y: 10, width: 220, height: 2)
        }
    }
    
}
