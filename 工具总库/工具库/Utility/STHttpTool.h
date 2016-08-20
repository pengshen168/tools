//
//  STHttpTool.h
//  XiaoShenTu
//
//  Created by 张云飞 on 16/7/6.
//  Copyright © 2016年 万启鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STHttpTool : NSObject

+ (NSString *)httpHeaderFieldString;

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSMutableDictionary *)params  constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))constructingBodyWithBlock success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


@end
