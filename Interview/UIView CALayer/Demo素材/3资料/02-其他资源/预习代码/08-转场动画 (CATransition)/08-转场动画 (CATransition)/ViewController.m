//
//  ViewController.m
//  08-转场动画 (CATransition)
//
//  Created by Romeo on 15/7/30.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView* imageView;

@property (nonatomic, assign) int imageName;

@end

@implementation ViewController

- (IBAction)swipe:(UISwipeGestureRecognizer*)sender
{
    // 换图片
    self.imageName++;

    if (self.imageName == 5) {
        self.imageName = 0;
    }

    // 获取图片的名字
    NSString* imageName = [NSString stringWithFormat:@"%d", self.imageName + 1];

    // 根据名字获取图片
    UIImage* image = [UIImage imageNamed:imageName];

    // 赋值
    self.imageView.image = image;

    // 转场动画
    CATransition* anim = [[CATransition alloc] init];
    anim.type = @"cube";

    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        anim.subtype = kCATransitionFromRight;
    }
    else {
        anim.subtype = kCATransitionFromLeft;
    }

    [self.imageView.layer addAnimation:anim forKey:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

@end
