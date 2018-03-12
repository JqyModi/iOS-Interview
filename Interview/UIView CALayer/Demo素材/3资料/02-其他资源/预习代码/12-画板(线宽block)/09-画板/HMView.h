//
//  HMView.h
//  09-画板
//
//  Created by Romeo on 15/7/30.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMView : UIView

// 线宽
@property (nonatomic, assign) CGFloat lineWidth;
// 颜色
@property (nonatomic, strong) UIColor* lineColor;

@property (nonatomic, copy) CGFloat (^lineWidthBlock)();

// 清屏
- (void)clearScreen;

// 回退
- (void)back;

// 橡皮
- (void)eraser;

@end
