//
//  ViewController.m
//  手势解锁
//
//  Created by Romeo on 15/12/8.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "ViewController.h"
#import "HMView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet HMView* passwordView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // 设置控制器 view 的背景为一张图片(平铺)
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];

    self.passwordView.passwordBlock = ^(NSString* pwd) {

        if ([pwd isEqualToString:@"012"]) {
            //
            NSLog(@"正确");
            return YES;
        }
        else {
            NSLog(@"错误");

            return NO;
        }
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
