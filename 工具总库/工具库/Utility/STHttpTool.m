//
//  STHttpTool.m
//  XiaoShenTu
//
//  Created by 张云飞 on 16/7/6.
//  Copyright © 2016年 万启鹏. All rights reserved.
//

#import "STHttpTool.h"
#import <AdSupport/AdSupport.h>
#import "HP_NetWorkUtils.h"
#import "DBHelper.h"
#import "STLoginViewController.h"
#import "STNavigationController.h"
@interface STHttpTool ()<UIAlertViewDelegate>

@end
@implementation STHttpTool

+ (NSString *)httpHeaderFieldString
{
    NSString *uuid = @"";
     XSTUserDefault *userDF  = [XSTUserDefault sharedXSTUserDefault];
    [userDF loadUserInfoFormSanbox];
    if (userDF.uuid) {//沙盒里有
        uuid = userDF.uuid;
    }else{
        uuid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        userDF.uuid = uuid;
        [userDF saveUserInfoToSanbox];

    }
    //版本
    NSString *app_v = @"V1.0.0";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (app_Version != nil) {
        app_v = [NSString stringWithFormat:@"V%@",app_Version];
    }
    NSString *agent = [NSString stringWithFormat:@"%@/%@",uuid,app_v];
    return agent;
    
}

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [MBProgressHUD showError:@"网络不可用，请您检查网络！"];
        
        return;
    }
    
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:url]];
    NSLog(@"%@",cookies);
    
    
    NSDictionary *cookieHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    NSLog(@"%@",cookieHeaders);
    NSString *cookie = [cookieHeaders objectForKey:@"Cookie"];
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    [[XSTUserDefault sharedXSTUserDefault]loadUserInfoFormSanbox];
    if ([XSTUserDefault sharedXSTUserDefault].cookie != nil) {//本地有cookie
        if ([url containsString:@"loginInfo/add"]) {// 从新登陆了
            [XSTUserDefault sharedXSTUserDefault].cookie = cookie;
            [[XSTUserDefault sharedXSTUserDefault] saveUserInfoToSanbox];
            [mgr.requestSerializer setValue:[XSTUserDefault sharedXSTUserDefault].cookie  forHTTPHeaderField:@"Cookie"];
        }else{// 没有重新登陆取本地的cookie
            [mgr.requestSerializer setValue:[XSTUserDefault sharedXSTUserDefault].cookie  forHTTPHeaderField:@"Cookie"];
        }
        
        
    }else{
        [XSTUserDefault sharedXSTUserDefault].cookie = cookie;
        [[XSTUserDefault sharedXSTUserDefault] saveUserInfoToSanbox];
        [mgr.requestSerializer setValue:[XSTUserDefault sharedXSTUserDefault].cookie  forHTTPHeaderField:@"Cookie"];
    }
    
    
    
    
    NSLog(@"%@",[XSTUserDefault sharedXSTUserDefault].cookie);

    
    
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if ([responseObject[@"code"]intValue] == 401) {// 登录过期请重新登录
            
            [MBProgressHUD showError:responseObject[@"message"]];
            [[XSTUserDefault sharedXSTUserDefault]loadUserInfoFormSanbox];
            [XSTUserDefault sharedXSTUserDefault].rongToken = nil;
            [XSTUserDefault sharedXSTUserDefault].cookie = nil;
            [[XSTUserDefault sharedXSTUserDefault]saveUserInfoToSanbox];
            
            [DBHelper closeDataBase];
            
            
            STLoginViewController *loginVC = [[STLoginViewController alloc]init];
            STNavigationController *nav3 = [[STNavigationController alloc]initWithRootViewController:loginVC];
            loginVC.view.backgroundColor = [UIColor whiteColor];
            
            
            AppDelegate *delegate = (AppDelegate *)APPDELEGATE;
            
            delegate.sideViewController = nil;
            [APPDELEGATE window].rootViewController = nav3;
            
            
            [[RCIMClient sharedRCIMClient] logout];
            
            
            
            return ;
        }

        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)post:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [MBProgressHUD showError:@"网络不可用，请您检查网络！"];
        
        return;
    }
    
    // 1.创建请求管理者

    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"content-type"];
//    [mgr.requestSerializer setValue:[self httpHeaderFieldString] forHTTPHeaderField:@"User-Agent"];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:url]];
    NSLog(@"%@",cookies);
    
    
    NSDictionary *cookieHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    NSLog(@"%@",cookieHeaders);
    NSString *cookie = [cookieHeaders objectForKey:@"Cookie"];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    [[XSTUserDefault sharedXSTUserDefault]loadUserInfoFormSanbox];
    if ([XSTUserDefault sharedXSTUserDefault].cookie != nil) {//本地有cookie
        if ([url containsString:@"loginInfo/add"]) {// 从新登陆了
            [XSTUserDefault sharedXSTUserDefault].cookie = cookie;
            [[XSTUserDefault sharedXSTUserDefault] saveUserInfoToSanbox];
            [mgr.requestSerializer setValue:[XSTUserDefault sharedXSTUserDefault].cookie  forHTTPHeaderField:@"Cookie"];
        }else{// 没有重新登陆取本地的cookie
            [mgr.requestSerializer setValue:[XSTUserDefault sharedXSTUserDefault].cookie  forHTTPHeaderField:@"Cookie"];
        }
        
        
    }else{
        [XSTUserDefault sharedXSTUserDefault].cookie = cookie;
        [[XSTUserDefault sharedXSTUserDefault] saveUserInfoToSanbox];
        [mgr.requestSerializer setValue:[XSTUserDefault sharedXSTUserDefault].cookie  forHTTPHeaderField:@"Cookie"];
    }
    
    
    
    
     NSLog(@"%@",[XSTUserDefault sharedXSTUserDefault].cookie);


    
    
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if ([responseObject[@"code"]intValue] == 401) {// 登录过期请重新登录
            
            [MBProgressHUD showError:responseObject[@"message"]];
            [[XSTUserDefault sharedXSTUserDefault]loadUserInfoFormSanbox];
            [XSTUserDefault sharedXSTUserDefault].rongToken = nil;
            [XSTUserDefault sharedXSTUserDefault].cookie = nil;
            [[XSTUserDefault sharedXSTUserDefault]saveUserInfoToSanbox];

            [DBHelper closeDataBase];
            
            
            STLoginViewController *loginVC = [[STLoginViewController alloc]init];
            STNavigationController *nav3 = [[STNavigationController alloc]initWithRootViewController:loginVC];
            loginVC.view.backgroundColor = [UIColor whiteColor];

            
            AppDelegate *delegate = (AppDelegate *)APPDELEGATE;

            delegate.sideViewController = nil;
            [APPDELEGATE window].rootViewController = nav3;
            
            
            [[RCIMClient sharedRCIMClient] logout];

            
            
            return ;
        }
        
        
        if (success) {
            
            
            
            
//            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//            for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//                NSLog(@"%@", cookie.value);
//                [[NSUserDefaults standardUserDefaults] setObject:cookie.value forKey:@"UserCookies"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//            }
            
//            NSArray *cookieStorage = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
//            NSDictionary *cookieHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookieStorage];
//            NSMutableURLRequest *request = [myRequestSerializer requestWith…];
//            for (NSString *key in cookieHeaders) {
//                [request addValue:cookieHeaders[key] forHTTPHeaderField:key];
//            }
//            NSString *cookieString = [[task.response allHeaderFields] valueForKey:@"Set-Cookie"];
//            NSMutableString *finalCookie = [NSMutableString new];
//            //                      NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookieString];
//            NSArray *cookieStrings = [cookieString componentsSeparatedByString:@","];
//            for(NSString* temp in cookieStrings)
//            {
//                NSArray *tempArr = [temp componentsSeparatedByString:@";"];
//                [finalCookie appendString:[NSString stringWithFormat:@"%@;",tempArr[0]]];
//            }
//            [[NSUserDefaults standardUserDefaults] setObject:finalCookie forKey:@"UserCookies"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}
+ (void)post:(NSString *)url params:(NSMutableDictionary *)params  constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>  _Nonnull formData))constructingBodyWithBlock success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [MBProgressHUD showError:@"网络不可用，请您检查网络！"];
        
        return;
    }
    // 1.创建请求管理者
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    //    [mgr.requestSerializer setValue:[self httpHeaderFieldString] forHTTPHeaderField:@"User-Agent"];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:url]];
    NSLog(@"%@",cookies);
    
    
    NSDictionary *cookieHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    NSLog(@"%@",cookieHeaders);
    NSString *cookie = [cookieHeaders objectForKey:@"Cookie"];
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    [[XSTUserDefault sharedXSTUserDefault]loadUserInfoFormSanbox];
    if ([XSTUserDefault sharedXSTUserDefault].cookie != nil) {//本地有cookie
        if ([url containsString:@"loginInfo/add"]) {// 从新登陆了
            [XSTUserDefault sharedXSTUserDefault].cookie = cookie;
            [[XSTUserDefault sharedXSTUserDefault] saveUserInfoToSanbox];
            [mgr.requestSerializer setValue:[XSTUserDefault sharedXSTUserDefault].cookie  forHTTPHeaderField:@"Cookie"];
        }else{// 没有重新登陆取本地的cookie
            [mgr.requestSerializer setValue:[XSTUserDefault sharedXSTUserDefault].cookie  forHTTPHeaderField:@"Cookie"];
        }
        
        
    }else{
        [XSTUserDefault sharedXSTUserDefault].cookie = cookie;
        [[XSTUserDefault sharedXSTUserDefault] saveUserInfoToSanbox];
        [mgr.requestSerializer setValue:[XSTUserDefault sharedXSTUserDefault].cookie  forHTTPHeaderField:@"Cookie"];
    }
    
    
    
    
    NSLog(@"%@",[XSTUserDefault sharedXSTUserDefault].cookie);
    
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (formData) {
            constructingBodyWithBlock(formData);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}
@end
