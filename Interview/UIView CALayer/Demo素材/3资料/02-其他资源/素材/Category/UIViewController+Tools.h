//
//  UIViewController+Tools.h
//  12-暂停恢复动画
//
//  Created by 刘凡 on 14/7/16.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Tools)

/** 暂停CALayer的动画 */
- (void)pauseLayer:(CALayer*)layer;
/** pragma mark 恢复CALayer的动画 */
- (void)resumeLayer:(CALayer*)layer;

@end
