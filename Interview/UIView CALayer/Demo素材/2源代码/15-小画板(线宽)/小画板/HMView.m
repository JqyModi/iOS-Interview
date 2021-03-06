//
//  HMView.m
//  小画板
//
//  Created by Romeo on 15/12/9.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMView.h"

@interface HMView ()

//@property (nonatomic, strong) UIBezierPath* path;

@property (nonatomic, strong) NSMutableArray* paths; // 管理路径的数组

@end

@implementation HMView

- (NSMutableArray*)paths
{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }

    return _paths;
}

//// 懒加载 创建路径
//- (UIBezierPath*)path
//{
//    if (!_path) {
//        _path = [[UIBezierPath alloc] init];
//    }
//    return _path;
//}

// 手指在这个 view 上触摸的时候调用
- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
    // 获取触摸对象
    UITouch* t = touches.anyObject;

    // 获取手指的位置
    CGPoint p = [t locationInView:t.view];

    UIBezierPath* path = [[UIBezierPath alloc] init];

    // 设置线宽
    [path setLineWidth:self.lineWidth];

    // 起点
    [path moveToPoint:p];

    // 把每一次新创建的路径 添加到数组当中
    [self.paths addObject:path];
}

// 手指在这个 view 上移动的时候调用
- (void)touchesMoved:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
    // 获取触摸对象
    UITouch* t = touches.anyObject;

    // 获取手指的位置
    CGPoint p = [t locationInView:t.view];

    // 连线的点
    [[self.paths lastObject] addLineToPoint:p];

    // 重绘
    [self setNeedsDisplay];
}

// 画线
- (void)drawRect:(CGRect)rect
{

    // 遍历所有的路径
    for (UIBezierPath* path in self.paths) {
        // 设置连接处的样式
        [path setLineJoinStyle:kCGLineJoinRound];

        // 设置头尾的样式
        [path setLineCapStyle:kCGLineCapRound];

        // 渲染
        [path stroke];
    }
}

@end
