//
//  ViewController.m
//  09-画板
//
//  Created by Romeo on 15/7/30.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "ViewController.h"
#import "HMView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet HMView* paintView;
@property (weak, nonatomic) IBOutlet UISlider* lineWidthProgressView;

@end

@implementation ViewController

// 滑动条滑动的时候调用
- (IBAction)lineWidthChange:(UISlider*)sender
{
    // 滑动的时候 设置线宽
    self.paintView.lineWidth = sender.value;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.paintView.lineWidth = self.lineWidthProgressView.value;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
