//
//  MDRNavigationController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRNavigationController.h"

@interface MDRNavigationController ()

@end

@implementation MDRNavigationController


+ (void)initialize {

    // 1.获取外观代理对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 2.设置标题颜色
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [UIColor blackColor]
                                    }];
    
    // 3.设置按钮颜色
    [navBar setTintColor:MDRThemeColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
