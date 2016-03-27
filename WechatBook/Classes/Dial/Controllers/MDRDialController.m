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
#import "MDRNavigationController.h"

@interface MDRYellowButton : UIButton

@end


@implementation MDRYellowButton

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.titleLabel.x = 0;
    self.imageView.x = self.titleLabel.width + 2;
    
}

@end


@interface MDRDialController () <CNContactViewControllerDelegate, CNContactPickerDelegate> {
    NSString *_phoneNumber;
}

@end

@implementation MDRDialController

#pragma mark - 使用dialView替换掉控制器的view
- (void)loadView {

    self.view = [[MDRDialView alloc] initWithFrame:[UIScreen mainScreen].bounds];

}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    // MARK: - 导航栏背景透明
    // 设置一个没有内容的图片即可
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    MDRDialView *dialView = (MDRDialView *)self.view;
    
    
    // MARK: - 黄页按钮
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
    
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - CNContactViewControllerDelegate
- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(nullable CNContact *)contact {
    
    // 销毁控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CNContactPickerViewControllerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {

    MDRLog(@"选中某个联系人后，会自己dismiss掉  %@", contact.familyName);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        CNMutableContact *mutableCt = [CNMutableContact all
        
        CNContactViewController *vc = [CNContactViewController viewControllerForContact:contact];
        
        vc.allowsEditing = YES;
        vc.shouldShowLinkedContacts = YES;
        vc.navigationItem.title = @"添加到已有";
        
        MDRNavigationController *nav = [[MDRNavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:nil];
        
        
    });
    
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {

    MDRLog(@"点击了取消按钮");
    
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
