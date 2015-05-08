//
//  PickTargetView.m
//  colorPalettePickerDemo
//
//  Created by SDC-Henry on 2015/4/24.
//  Copyright (c) 2015年 _LACK_. All rights reserved.
//

#import "PickTargetView.h"

@implementation PickTargetView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat radius = CGRectGetMidX([self bounds]);
    CGPoint center = {CGRectGetMidX([self bounds]), CGRectGetMidY([self bounds])};
    
    //draw circle
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.0);
    
    CGContextAddArc(context, center.x, center.y, radius, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    /*
    // Fill it:
    
    CGContextAddArc(context, center.x, center.y, radius - 1.0f, 0.0f, 2.0f * (float) M_PI, YES);
    [self.color setFill];
    CGContextFillPath(context);
    
    // Stroke it (black transucent, inner):
    
    CGContextAddArc(context, center.x, center.y, radius - 1.0f, 0.0f, 2.0f * (float) M_PI, YES);
    CGContextSetGrayStrokeColor(context, 0.0f, 0.5f);
    CGContextSetLineWidth(context, 2.0f);
    CGContextStrokePath(context);
    
    // Stroke it (white, outer):
    
    CGContextAddArc(context, center.x, center.y, radius - 2.0f, 0.0f, 2.0f * (float) M_PI, YES);
    CGContextSetGrayStrokeColor(context, 1.0f, 1.0f);
    CGContextSetLineWidth(context, 2.0f);
    CGContextStrokePath(context);
    */
}


@end
