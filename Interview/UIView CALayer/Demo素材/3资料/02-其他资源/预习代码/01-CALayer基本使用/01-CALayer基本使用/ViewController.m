//
//  ViewController.m
//  01-CALayer基本使用
//
//  Created by Romeo on 15/7/30.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "ViewController.h"
#import "HMView.h"

@interface ViewController ()

@property (nonatomic, weak) HMView* hmview;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{

    self.hmview.layer.position = CGPointMake(200, 400);

    [super touchesBegan:touches withEvent:event];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // 创建了一个UIView对象
    HMView* testView = [[HMView alloc] init];
    self.hmview = testView;
    testView.frame = CGRectMake(100, 100, 100, 100);
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];

    // 设置layer边框
    testView.layer.borderWidth = 10; // 边框的宽度
    testView.layer.borderColor = [UIColor whiteColor].CGColor; // 边框的颜色

    // 设置layer阴影
    testView.layer.shadowColor = [UIColor blueColor].CGColor; // 颜色
    testView.layer.shadowOffset = CGSizeMake(20, 20); // 偏移量
    testView.layer.shadowOpacity = 0.7; // 透明度 默认为0,所以不会显示.
    testView.layer.shadowRadius = 10; //圆角

    // 设置layer圆角
    testView.layer.cornerRadius = 50; // 设置layer的圆角半径
    testView.layer.masksToBounds = YES; // 裁剪 设置头像的时候 记得加上

    // bounds 大小
    //    testView.layer.bounds = CGRectMake(0, 0, 200, 200);

    // position 位置
    //    testView.layer.position = CGPointMake(0, 0); // 默认的位置是view得center

    // 设置内容 (__bridge id)把cg转化成id
    testView.layer.contents = (__bridge id)([UIImage imageNamed:@"haoyuexing"].CGImage); // 图片
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
