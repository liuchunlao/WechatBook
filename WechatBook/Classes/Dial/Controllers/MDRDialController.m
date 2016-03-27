//
//  MDRDialController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRDialController.h"
#import "MDRYellowPageController.h"
#import "MDRDialView.h"

@interface MDRYellowButton : UIButton

@end


@implementation MDRYellowButton

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.titleLabel.x = 0;
    self.imageView.x = self.titleLabel.width + 2;
    
}

@end


@interface MDRDialController ()

@end

@implementation MDRDialController

#pragma mark - 使用dialView替换掉控制器的view
- (void)loadView {

    self.view = [[MDRDialView alloc] initWithFrame:[UIScreen mainScreen].bounds];

}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MDRDialView *dialView = (MDRDialView *)self.view;
    
    
    typeof (self) weakSelf = self;
    dialView.hideNavBar = ^(BOOL isContain) {
    
        if (isContain) {
            [weakSelf.navigationController.navigationBar setHidden:YES];
        } else {
        
            [weakSelf.navigationController.navigationBar setHidden:NO];
        }
        
    };
    
#pragma mark - 黄页按钮
    
    // 1.按钮
    MDRYellowButton *yellowBtn = [MDRYellowButton buttonWithType:UIButtonTypeCustom];
    
    // 2.文字图片
    [yellowBtn setTitle:@"黄页" forState:UIControlStateNormal];
    [yellowBtn setTitleColor:MDRThemeColor forState:UIControlStateNormal];
    [yellowBtn setImage:[UIImage imageNamed:@"icon_dialArrow"] forState:UIControlStateNormal];
    
    // 2.2 自适应大小
    [yellowBtn sizeToFit];
    
    // 3.包成item
    UIBarButtonItem *pageItem = [[UIBarButtonItem alloc] initWithCustomView:yellowBtn];
    self.navigationItem.rightBarButtonItem = pageItem;
    
    // 4.注册事件
    [yellowBtn addTarget:self action:@selector(yellowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - 导航栏背景透明
    // 设置一个没有内容的图片即可
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - 跳转到黄页控制器
- (void)yellowBtnClick {

    MDRYellowPageController *yellowPageVc = [[MDRYellowPageController alloc] init];
    [self.navigationController pushViewController:yellowPageVc animated:YES];
}


#pragma mark - 实现选中拨号的时候底部的工具条是看不见线条
// 并且工具条背景跟控制器背景一直
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    // 1.让底部的工具条跟barTintColor与控制器背景一致
    [self.tabBarController.tabBar setBarTintColor:self.view.backgroundColor];
    // 2.修改样式
    [self.tabBarController.tabBar setBarStyle:UIBarStyleBlackOpaque];
    

}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    // 1.将tintColor改回去
    [self.tabBarController.tabBar setBarTintColor:nil];
    // 2.改为默认样式
    [self.tabBarController.tabBar setBarStyle:UIBarStyleDefault];

}


@end
