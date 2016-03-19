//
//  MDRDialController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRDialController.h"

@interface MDRDialController ()

@end

@implementation MDRDialController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - 实现选中拨号的时候底部的工具条是看不见线条
// 并且工具条背景跟控制器背景一直
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    // 1.让底部的工具条跟barTintColor与控制器背景一直
    [self.tabBarController.tabBar setBarTintColor:self.view.backgroundColor];
    
    // 2.修改样式
    [self.tabBarController.tabBar setBarStyle:UIBarStyleBlack];
    
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    // 1.将tintColor改回去
    [self.tabBarController.tabBar setBarTintColor:nil];
    // 2.改为默认样式
    [self.tabBarController.tabBar setBarStyle:UIBarStyleDefault];

}




@end
