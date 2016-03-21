//
//  AppDelegate.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "AppDelegate.h"
#import "MDRTabBarController.h"
//#import <AddressBook/AddressBook.h>



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 2.设置根控制器
    self.window.rootViewController = [[MDRTabBarController alloc] init];
    
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    
    
#pragma mark - 访问通讯录授权
    // 1.创建通讯录对象
    CNContactStore *store = [[CNContactStore alloc] init];
    
    // 2.获取当前授权状态
    CNAuthorizationStatus currentStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    switch (currentStatus) {
        case CNAuthorizationStatusAuthorized:
            MDRLog(@"用户已经许可了");
            break;
            
        case CNAuthorizationStatusDenied:
            MDRLog(@"用户拒绝了");
            break;
            
        case CNAuthorizationStatusNotDetermined:
            MDRLog(@"还么有决定");
            
            // 请求用户许可
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                
                // grant 授予
                if (granted) {
                    MDRLog(@"授权成功");
                    
                } else {
                
                    MDRLog(@"授权错误信息=>%@", error);
                }
            }];
            break;
            
        case CNAuthorizationStatusRestricted:
            MDRLog(@"被限制了");
            break;
            
        default:
            break;
    }
    

    return YES;
}


@end
