//
//  TargetImageView.m
//  colorPalettePickerDemo
//
//  Created by SDC-Henry on 2015/4/29.
//  Copyright (c) 2015年 _LACK_. All rights reserved.
//

#import "TargetImageView.h"

@implementation TargetImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat radius = CGRectGetMidX([self bounds]);
    CGPoint center = {CGRectGetMidX([self bounds]), CGRectGetMidY([self bounds])};
    
    //draw circle
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 2.0);
     
    CGContextAddArc(context, center.x, center.y, radius, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
    
}


@end
