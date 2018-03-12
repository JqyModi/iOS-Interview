//
//  HMView.m
//  09-画板
//
//  Created by Romeo on 15/7/30.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HMView.h"

@interface HMView ()

//@property (nonatomic, strong) UIBezierPath* path;

@property (nonatomic, strong) NSMutableArray* paths;

@end

@implementation HMView

// 懒加载
- (NSMutableArray*)paths
{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

//- (UIBezierPath*)path
//{
//    if (!_path) {
//        _path = [UIBezierPath bezierPath];
//    }
//    return _path;
//}

// 触摸开始

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch* t = touches.anyObject;
    // 获取当前触摸的点
    CGPoint point = [t locationInView:t.view];

    // 创建路径对象
    UIBezierPath* path = [UIBezierPath bezierPath];
    // 设置线宽
    [path setLineWidth:self.lineWidth];
    [path moveToPoint:point];

    // 添加到数组中
    [self.paths addObject:path];
}

// 触摸移动
- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch* t = touches.anyObject;
    // 获取当前触摸的点
    CGPoint point = [t locationInView:t.view];
    //    [self.path addLineToPoint:point];
    // 让最后添加的路径 addline
    [[self.paths lastObject] addLineToPoint:point];
    // 重绘
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code

    // 渲染
    for (UIBezierPath* path in self.paths) {
        [path setLineCapStyle:kCGLineCapRound];
        [path setLineJoinStyle:kCGLineJoinRound];
        [path stroke];
    }
}

@end
