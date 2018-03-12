//
//  HMView.m
//  09-画板
//
//  Created by Romeo on 15/7/30.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HMView.h"
#import "HMBezierPath.h"

@interface HMView ()

//@property (nonatomic, strong) HMBezierPath* path;

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

//- (HMBezierPath*)path
//{
//    if (!_path) {
//        _path = [HMBezierPath bezierPath];
//    }
//    return _path;
//}

// 清屏
- (void)clearScreen
{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

// 回退
- (void)back
{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}

// 橡皮
- (void)eraser
{
    self.lineColor = self.backgroundColor;
}

// 触摸开始
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch* t = touches.anyObject;
    // 获取当前触摸的点
    CGPoint point = [t locationInView:t.view];

    // 创建路径对象
    HMBezierPath* path = [[HMBezierPath alloc] init];

    if (self.lineWidthBlock) {
        // 设置线宽
        [path setLineWidth:self.lineWidthBlock()];
    }

    // 设置颜色
    [path setLineColor:self.lineColor];

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
    for (HMBezierPath* path in self.paths) {
        [path.lineColor set];
        [path setLineCapStyle:kCGLineCapRound];
        [path setLineJoinStyle:kCGLineJoinRound];
        [path stroke];
    }
}

@end
