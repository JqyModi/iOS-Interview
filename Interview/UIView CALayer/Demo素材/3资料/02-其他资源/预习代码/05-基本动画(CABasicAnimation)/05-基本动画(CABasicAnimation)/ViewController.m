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
    layer.frame = CGRectMake(100, 100, 100, 200);
    layer.backgroundColor = [UIColor redColor].CGColor;

    [self.view.layer addSublayer:layer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
