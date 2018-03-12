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
    // 旋转

    //    self.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 0, 0);

    // x
    //    self.layer.transform = CATransform3DRotate(self.layer.transform, M_PI_4, 1, 0, 0);
    // y
    //    self.layer.transform = CATransform3DRotate(self.layer.transform, M_PI_4, 0, 1, 0);
    // z
    //    self.layer.transform = CATransform3DRotate(self.layer.transform, M_PI_4, 0, 0, 1);

    // 缩放
    // x
    //    self.layer.transform = CATransform3DScale(self.layer.transform, 0.5, 1, 1);
    // y
    //    self.layer.transform = CATransform3DScale(self.layer.transform, 1, 0.5, 1);
    // z (无效果)
    //    self.layer.transform = CATransform3DScale(self.layer.transform, 1, 1, 0.5);

    // 平移
    // z (无效果)
    self.layer.transform = CATransform3DTranslate(self.layer.transform, 100, 100, 100);
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
