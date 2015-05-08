//
//  ParentPaletteView.h
//  colorPalettePickerDemo
//
//  Created by SDC-Henry on 2015/4/24.
//  Copyright (c) 2015年 _LACK_. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PickTargetView.h"
#import "TargetImageView.h"

@interface ParentPaletteView : UIControl {
    
    PickTargetView *targetView;
    
    UIImageView *paletteImageView;
    UIImageView *targetImageView;
    
    UIImage *paletteImage;
    
    CGContextRef context;
    
    CGPoint touchPoint;
}

@end
