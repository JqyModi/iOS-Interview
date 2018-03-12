//
//  ViewController.m
//  05-基本动画(CABasicAnimation)
//
//  Created by Romeo on 15/7/30.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) CALayer* layer;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
}

// 关键帧动画 - 图标抖动
- (void)test4
{
    // 关键帧动画
    // 创建关键帧动画的对象
    CAKeyframeAnimation* anim = [[CAKeyframeAnimation alloc] init];

    // 操作
    anim.keyPath = @"transform.rotation";

    // 设置关键帧
    anim.values = @[ @(M_PI_4 * 0.3), @(-M_PI_4 * 0.3), @(M_PI_4 * 0.3) ];

    anim.duration = 2;
    anim.repeatCount = INT_MAX;

    // 把动画添加到layer上
    [self.layer addAnimation:anim forKey:nil];
}

// 关键帧动画 - path
- (void)test3
{
    // 关键帧动画
    // 创建关键帧动画的对象
    CAKeyframeAnimation* anim = [[CAKeyframeAnimation alloc] init];

    // 操作
    anim.keyPath = @"position";

    //    UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)];

    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:50 startAngle:0 endAngle:2 * M_PI clockwise:1];

    anim.path = path.CGPath;

    //    NSValue* v1 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    //    NSValue* v2 = [NSValue valueWithCGPoint:CGPointMake(150, 50)];
    //    NSValue* v3 = [NSValue valueWithCGPoint:CGPointMake(50, 150)];
    //    NSValue* v4 = [NSValue valueWithCGPoint:CGPointMake(150, 150)];
    //
    //    // 通过values这个属性 添加关键帧
    //    anim.values = @[ v1, v2, v3, v4 ];

    anim.duration = 1;
    anim.repeatCount = INT_MAX;

    // 把动画添加到layer上
    [self.layer addAnimation:anim forKey:nil];
}

// 关键帧动画 - values
- (void)test2
{
    // 关键帧动画
    // 创建关键帧动画的对象
    CAKeyframeAnimation* anim = [[CAKeyframeAnimation alloc] init];

    // 操作
    anim.keyPath = @"position";

    NSValue* v1 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    NSValue* v2 = [NSValue valueWithCGPoint:CGPointMake(150, 50)];
    NSValue* v3 = [NSValue valueWithCGPoint:CGPointMake(50, 150)];
    NSValue* v4 = [NSValue valueWithCGPoint:CGPointMake(150, 150)];

    // 通过values这个属性 添加关键帧
    anim.values = @[ v1, v2, v3, v4 ];

    anim.duration = 10;

    // 把动画添加到layer上
    [self.layer addAnimation:anim forKey:nil];
}

// 基本动画
- (void)test1
{
    // 创建动画
    CABasicAnimation* anim = [[CABasicAnimation alloc] init];

    // 动画操作
    anim.keyPath = @"transform.scale";
    //    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    //    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 400)];

    //    anim.byValue = [NSValue valueWithCGPoint:CGPointMake(10, 10)];
    anim.byValue = @(0.5);
    anim.removedOnCompletion = NO; // 如果不设置  那么 fillmode 无效
    anim.fillMode = kCAFillModeForwards;

    //    anim.duration = 1;
    //            anim.repeatCount = INT_MAX;

    //    self.layer.position = CGPointMake(300, 400);

    // 让layer添加动画
    [self.layer addAnimation:anim forKey:nil];

    NSLog(@"%@", NSStringFromCGRect(self.layer.frame));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    CALayer* layer = [[CALayer alloc] init];
    self.layer = layer;
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;

    [self.view.layer addSublayer:layer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
