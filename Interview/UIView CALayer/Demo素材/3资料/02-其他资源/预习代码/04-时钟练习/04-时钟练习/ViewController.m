//
//  ViewController.m
//  04-时钟练习
//
//  Created by Romeo on 15/7/30.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) CALayer* second;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // 创建一个CALayer
    CALayer* clock = [[CALayer alloc] init];
    clock.frame = CGRectMake(100, 100, 200, 200);
    clock.contents = (__bridge id)([UIImage imageNamed:@"clock"].CGImage); // 设置内容
    clock.cornerRadius = 100; // 设置圆角
    clock.masksToBounds = YES; // 设置裁剪

    CALayer* second = [[CALayer alloc] init];
    self.second = second;
    second.position = clock.position; // 设置位置
    second.bounds = CGRectMake(0, 0, 2, 80); // 设置大小
    second.backgroundColor = [UIColor redColor].CGColor; // 颜色

    // 锚点  定位点
    second.anchorPoint = CGPointMake(0.5, 0.8); // 设置锚点!!!!!!!!!

    // 添加到控制器view的layer上去
    [self.view.layer addSublayer:clock];
    [self.view.layer addSublayer:second];

    //    [self time];

    // 添加定时器 每一秒调用 time 的方法
    //    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time) userInfo:nil repeats:YES];

    // 创建一个CADisplayLink对象
    CADisplayLink* link = [CADisplayLink displayLinkWithTarget:self selector:@selector(time)];
    // 把 link 添加到 主消息循环当中
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)time
{

    // 1 ----------  NSDate
    NSDate* date = [NSDate date];
    //    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //    formatter.dateFormat = @"ss";
    //    CGFloat second = [[formatter stringFromDate:date] floatValue];
    // ----------  NSDate

    // 2 ----------  NSCalendar
    // 获取当前日历对象
    NSCalendar* cal = [NSCalendar currentCalendar];
    // 获取其中某一部分的时间
    CGFloat second = [cal component:NSCalendarUnitSecond fromDate:date];
    // ----------  NSCalendar

    CGFloat angle = 2 * M_PI / 60 * second;
    // 每次旋转360/60度
    //  self.second.affineTransform = CGAffineTransformRotate(self.second.affineTransform, angle);
    self.second.affineTransform = CGAffineTransformMakeRotation(angle);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
