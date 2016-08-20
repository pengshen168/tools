//
//  UIImage+Resize.h
//  Biyouwoshi
//
//  Created by luanqiangqiang on 15/1/1.
//  Copyright (c) 2015年 BU54. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)


-(UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

+ (UIImage*)imageWithColor:(UIColor*)color;

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
@end
