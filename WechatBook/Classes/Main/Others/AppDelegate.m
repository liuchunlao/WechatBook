//
//  AppDelegate.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "AppDelegate.h"
#import "MDRTabBarController.h"

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

    return YES;
}


@end
