//
//  ViewController.m
//  02-手动创建layer
//
//  Created by Romeo on 15/7/30.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CALayer* layer;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    //    self.layer.position = CGPointMake(300, 400);

    //       CATransaction *ca = [[CATransaction alloc] init];
    // 禁止隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];

    self.layer.bounds = CGRectMake(0, 0, 300, 300);

    self.layer.opacity = 0;

    [CATransaction commit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // 创建layer
    CALayer* layer = [[CALayer alloc] init];
    self.layer = layer;
    layer.backgroundColor = [UIColor redColor].CGColor;
    // 设置frame
    //    layer.frame = CGRectMake(100, 100, 100, 100);
    // 设置大小
    layer.bounds = CGRectMake(0, 0, 100, 100);
    // 设置位置
    layer.position = CGPointMake(150, 150);

    // 把创建的layer 添加到 view的layer当中
    [self.view.layer addSublayer:layer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
