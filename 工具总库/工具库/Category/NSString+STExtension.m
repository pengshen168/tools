//
//  NSString+STExtension.m
//  XiaoShenTu
//
//  Created by 张云飞 on 16/7/20.
//  Copyright © 2016年 万启鹏. All rights reserved.
//

#import "NSString+STExtension.h"

@implementation NSString (STExtension)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    // 获得系统版本
    //    if (iOS7) {
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    //    } else {
    //        return [self sizeWithFont:font constrainedToSize:maxSize];
    //    }
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

@end
