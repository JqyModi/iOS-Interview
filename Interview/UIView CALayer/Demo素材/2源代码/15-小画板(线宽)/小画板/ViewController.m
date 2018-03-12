//
//  ViewController.m
//  小画板
//
//  Created by Romeo on 15/12/9.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "ViewController.h"
#import "HMView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet HMView* hmview;
@property (weak, nonatomic) IBOutlet UISlider* lineWidthProgress;

@end

@implementation ViewController

// 监听线宽改变
- (IBAction)lineWidthChange:(UISlider*)sender
{
    // 把最新的数值(线宽)给了 hmview
    self.hmview.lineWidth = sender.value;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // 默认线宽
    self.hmview.lineWidth = self.lineWidthProgress.value;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
