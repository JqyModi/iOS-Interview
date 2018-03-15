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
@property (weak, nonatomic) IBOutlet UIButton* blueButton;

@end

@implementation ViewController

// 清屏
- (IBAction)clearScreen:(id)sender
{
    [self.paintView clearScreen];
}

// 回退
- (IBAction)back:(id)sender
{
    [self.paintView back];
}

// 橡皮
- (IBAction)eraser:(id)sender
{
    [self.paintView eraser];
}

// 保存
- (IBAction)save:(id)sender
{
    // 开上下文
    UIGraphicsBeginImageContextWithOptions(self.paintView.frame.size, NO, 0);

    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // 截图
    [self.paintView.layer renderInContext:ctx];

    // 通过上下文拿图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();

    // 关上下文
    UIGraphicsEndImageContext();

    // 保存
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

// 点击各种颜色按钮执行
- (IBAction)lineColorChange:(UIButton*)sender
{

    // 设置颜色属性
    self.paintView.lineColor = sender.backgroundColor;
}

// 滑动条滑动的时候调用
//- (IBAction)lineWidthChange:(UISlider*)sender
//{
//    // 滑动的时候 设置线宽
//    self.paintView.lineWidth = sender.value;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
       
       // afn
 
    // 设置初始线宽
    //    self.paintView.lineWidth = self.lineWidthProgressView.value;
    [self.paintView setLineWidthBlock:^CGFloat {
        return self.lineWidthProgressView.value;
    }];

    // 设置初始颜色
    [self lineColorChange:self.blueButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
