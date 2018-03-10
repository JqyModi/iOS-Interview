//
//  BGView.m
//  xx-super touch began
//
//  Created by Romeo on 15/12/8.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "BGView.h"

@implementation BGView

- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{

    NSLog(@"BGView = touchesBegan");
    [super touchesBegan:touches withEvent:event];
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{

    NSLog(@"BGView = hitTest");
    return [super hitTest:point withEvent:event];
}

@end
