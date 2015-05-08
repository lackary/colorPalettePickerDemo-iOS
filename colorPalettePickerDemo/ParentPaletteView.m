//
//  ParentPaletteView.m
//  colorPalettePickerDemo
//
//  Created by SDC-Henry on 2015/4/24.
//  Copyright (c) 2015年 _LACK_. All rights reserved.
//

#import "ParentPaletteView.h"

@implementation ParentPaletteView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    /*
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 12], NSForegroundColorAttributeName: UIColor.redColor, NSParagraphStyleAttributeName: textStyle};
    
    [@"test draw word" drawInRect:CGRectMake(10.0, 10.0, 100, 20) withAttributes:textFontAttributes];
    
    //draw circle
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextAddArc(context, 35.0, 65.0, 25.0, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
    */
}

- (void) layoutSubviews {
    
    if (paletteImageView == nil) {
        CGGradientRef gradient = [self setGradientColorComponent];
        
        paletteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 20.0, 200.0, 200.0)];
        
        //set UIImageView border thickness
        [[paletteImageView layer] setBorderWidth:2.0];
        
        //set UIImageView border color
        [[paletteImageView layer] setBorderColor:[UIColor whiteColor].CGColor];
        
        //Create bitmap-base graphic context
        UIGraphicsBeginImageContext(paletteImageView.frame.size);
        context = UIGraphicsGetCurrentContext();
        
        //show the gradients by horizontal
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0, 0.0), CGPointMake(200.0, 0.0), 0);
        
        CGContextSaveGState(context);
        //show result
        
        paletteImage = UIGraphicsGetImageFromCurrentImageContext();
        //paletteImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        gradient = [self setGrayColorComponent];
        
        UIGraphicsBeginImageContext(paletteImageView.frame.size);
        context = UIGraphicsGetCurrentContext();
        
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0, 0.0), CGPointMake(0.0, 200.0), 0);
        
        CGContextSetBlendMode(context, kCGBlendModeMultiply);
        CGRect drawRect = CGRectMake(0.0, 0.0, paletteImageView.frame.size.width, paletteImageView.frame.size.height);
        CGContextDrawImage(context, drawRect, paletteImage.CGImage);
        
        CGContextSaveGState(context);
        
        paletteImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self addSubview:paletteImageView];
    }
    
    if(targetImageView == nil) {
        targetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 30.0, 30.0)];
        
        //set UIImageView border thickness
        [[targetImageView layer] setBorderWidth:2.0];
        
        //set UIImageView border color
        [[targetImageView layer] setBorderColor:[UIColor whiteColor].CGColor];
        
        //set UIImageView mask
        [[targetImageView layer] setMasksToBounds:YES];
        
        //draw a circle imageview, if the image width is 50 and height is 50
        
        targetImageView.layer.cornerRadius = 15;
        //[[circleImageView layer] setCornerRadius:25.0];
        
        targetImageView.image = [self ImageColorSetSize:targetImageView.frame.size setRed:255.0 setGreen:0.0 setBlue:0.0 setAlpha:1.0];
        targetImageView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
        [self addSubview:targetImageView];
        touchPoint = CGPointMake(20.0, 20.0);
    }
    
    NSLog(@"x:%f, y:%f", touchPoint.x, touchPoint.y);
    
    targetImageView.center = touchPoint;
    
    [self getRGBAWithImage:paletteImageView.image withPoint:touchPoint];
    /*
    if (targetView == nil) {
        targetView = [[PickTargetView alloc] initWithFrame:CGRectMake(20, 240, 30, 30)];
        targetView.backgroundColor= [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
        [self addSubview:targetView];
    }
    
    //targetView.center = CGPointMake(35.0, 35.0);
    */
}

- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    //NSLog(@"beginTrackingWithTouch");
    touchPoint= [touch locationInView:self];
    //targetImageView.center = point;
    if((touchPoint.x >=20) && (touchPoint.x <= 220) && (touchPoint.y >= 20) && (touchPoint.y <=220)) {
        [self setNeedsLayout];
    }
    
    return YES;
}

- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    //int x = [touch locationInView:self].x;
    //int y = [touch locationInView:self].y;
    
    //NSLog(@"continueTrackingWithTouch");
    touchPoint = [touch locationInView:self];
    //targetImageView.center = point;
    if((touchPoint.x >=20) && (touchPoint.x <= 220) && (touchPoint.y >= 20) && (touchPoint.y <=220)) {
        [self setNeedsLayout];
    }
    return YES;
}

- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    //NSLog(@"endTrackingWithTouch");
    touchPoint = [touch locationInView:self];
    //targetImageView.center = point;
    if((touchPoint.x >=20) && (touchPoint.x <= 220) && (touchPoint.y >= 20) && (touchPoint.y <=220)) {
        [self setNeedsLayout];
    }
}

- (CGGradientRef)setGradientColorComponent {
    //Set color space components
    
    CGColorSpaceRef rgba = CGColorSpaceCreateDeviceRGB();
    
    //set 7 key color componet
    CGFloat colorComponent[] = {1.0, 0.0, 0.0, 1.0, //Red, not transparent
                                1.0, 1.0, 0.0, 1.0, //Yellow, not transparent
                                0.0, 1.0, 0.0, 1.0, //Green, not transparent
                                0.0, 1.0, 1.0, 1.0, //Cyan / Aqua, not transparent
                                0.0, 0.0, 1.0, 1.0, //Blue, not transparent
                                1.0, 0.0, 1.0, 1.0, //Magenta / Fuchsia, not transparent
                                1.0, 0.0, 0.0, 1.0};//Red, not transparent
    
    
    //set the location of key color
    CGFloat location[] = {0.0, 0.16, 0.33, 0.50, 0.66, 0.82, 1.0};
    //set the number of location
    size_t count = 7;
    
    //create radient components
    CGGradientRef colorGradient = CGGradientCreateWithColorComponents(rgba, colorComponent, location, count);
    
    CGColorSpaceRelease(rgba);
    
    return colorGradient;
}

- (CGGradientRef) setGrayColorComponent {
    
    CGColorSpaceRef rgba = CGColorSpaceCreateDeviceRGB();
    
    CGFloat colorComponent[] = {1.0, 1.0, 1.0, 1.0,
                                0.75,0.75,0.75,1.0,
                                0.5, 0.5, 0.5, 1.0,
                                0.25,0.25,0.25,1.0,
                                0.0, 0.0, 0.0, 1.0};
    
    CGFloat location[] = {0.0, 0.25, 0.50, 0.75, 1.0};
    
    size_t count = 5;
    
    //create radient components
    CGGradientRef colorGradient = CGGradientCreateWithColorComponents(rgba, colorComponent, location, count);
    
    CGColorSpaceRelease(rgba);
    
    return colorGradient;
}

- (UIImage *) ImageColorSetSize:(CGSize)size setRed:(float)red setGreen:(float)green setBlue:(float)blue setAlpha:(float)alpha{
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    UIColor *color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
    [color setFill];
    //[[UIColor blackColor] setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void) getRGBAWithImage:(UIImage *)image withPoint:(CGPoint)point {
    
    CGImageRef imgRef = image.CGImage;
    
    unsigned long width = CGImageGetWidth(imgRef);
    unsigned long height = CGImageGetHeight(imgRef);
    
    CGColorSpaceRef colorSpc = CGColorSpaceCreateDeviceRGB();
    
    unsigned char *bitmap =  malloc(width * height * 4);
    
    size_t bytesPerRow = (width * 4);
    
    CGContextRef contextRGBA = CGBitmapContextCreate(bitmap, width, height, 8, bytesPerRow, colorSpc, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(colorSpc);
        
    CGContextDrawImage(contextRGBA, CGRectMake(0.0, 0.0, width, height), imgRef);
    
    CGContextRelease(contextRGBA);
    
    unsigned int index = (4 * (point.x - 20)) + (bytesPerRow * (point.y - 20));
    
    int R = bitmap[index];
    int G = bitmap[index + 1];
    int B = bitmap[index + 2];
    int A = bitmap[index + 3];
    
    int gray = (0.299 * R) + (0.587 * G) + (0.114 * B);
    
    NSLog(@"R: %d, G: %d, B: %d", R, G, B);
    
    free(bitmap);
}

@end
