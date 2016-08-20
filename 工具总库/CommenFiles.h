//
//  CommenFiles.h
//  工具总库
//
//  Created by 万启鹏 on 16/8/20.
//  Copyright © 2016年 万启鹏. All rights reserved.
//

#ifndef CommenFiles_h
#define CommenFiles_h

#define APPDELEGATE   (AppDelegate *)[UIApplication sharedApplication].delegate

#define XNotificationCenter [NSNotificationCenter defaultCenter]


#define XScreenW [UIScreen mainScreen].bounds.size.width
#define XScreenH [UIScreen mainScreen].bounds.size.height

//适配
#define XScaleHeight(height) XScreenH/1334*height
#define XScaleWidth(width) XScreenW/750*width

//字体
#define XFont(fontSize) [UIFont systemFontOfSize:XScaleWidth(fontSize)]
//颜色
#define XColor(text) [UIColor colorWithHexString:text]

//随机色
#define XRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0  blue:arc4random_uniform(256)/255.0  alpha:1.0]


#define is_ios6  [[[UIDevice currentDevice]systemVersion] floatValue]<7

#define is_ios7  [[[UIDevice currentDevice]systemVersion] floatValue]>=7

#define is_ios8  [[[UIDevice currentDevice]systemVersion] floatValue]>=8

#define is_ios9 [[[UIDevice currentDevice] systemVersion] floatValue]>=9



#define checkNull(__X__) [(__X__)isEqual:[NSNull null]] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//判断屏幕是否为iPhone4
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(XScreenW, XScreenH))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]



// 打印宏
#pragma mark - 打印宏

#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...)



#endif


#endif /* CommenFiles_h */
