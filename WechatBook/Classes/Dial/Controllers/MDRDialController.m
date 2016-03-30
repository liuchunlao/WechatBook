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
    
    
    

    typeof (self) weakSelf = self;
    // 隐藏导航条的回调
    dialView.hideNavBar = ^(BOOL isContain) {
    
        if (isContain) {
            [weakSelf.navigationController.navigationBar setHidden:YES];
        } else {
        
            [weakSelf.navigationController.navigationBar setHidden:NO];
        }
        
    };
    
    // 提示添加联系人的回调
    dialView.addContact = ^(NSString *phoneNumber) {
    
        // MARK: - 弹窗
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *create = [UIAlertAction actionWithTitle:@"新建联系人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            MDRLog(@"添加联系人");
            // 0.联系人
            CNMutableContact *ct = [[CNMutableContact alloc] init];
            
            // MARK: - 设置新建联系人的电话
            CNPhoneNumber *phoneNum = [CNPhoneNumber phoneNumberWithStringValue:phoneNumber];
            CNLabeledValue *lableValue = [CNLabeledValue labeledValueWithLabel:@"手机" value:phoneNum];
            
            ct.phoneNumbers = @[lableValue];
            
            // 1.创建控制器
            CNContactViewController *addContactVc = [CNContactViewController viewControllerForNewContact:ct];
            
            NSLog(@"%@", addContactVc.displayedPropertyKeys);
            
            // 1.2 设置代理
            addContactVc.delegate = self;
            
            // 1.3 设置标题
            addContactVc.navigationItem.title = @"新建联系人";
            
            // 2.包成导航控制器
            MDRNavigationController *nav = [[MDRNavigationController alloc] initWithRootViewController:addContactVc];
            
            // 3.显示控制器
            [self presentViewController:nav animated:YES completion:nil];
        
        }];
        
        UIAlertAction *addToOld = [UIAlertAction actionWithTitle:@"添加到现有联系人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // 1.创建picker
            CNContactPickerViewController *pickerVc = [[CNContactPickerViewController alloc] init];
            
            pickerVc.delegate = self;
            
            _phoneNumber = phoneNumber;
            
            // 2.显示
            [self presentViewController:pickerVc animated:YES completion:nil];
            
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertVc addAction:create];
        [alertVc addAction:addToOld];
        [alertVc addAction:cancel];
        
        [self presentViewController:alertVc animated:YES completion:nil];
        
    
    };
    
}

#pragma mark - 实现选中拨号的时候底部的工具条是看不见线条
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
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

#pragma mark - 跳转到黄页控制器
- (void)yellowBtnClick {
    
    MDRYellowPageController *yellowPageVc = [[MDRYellowPageController alloc] init];
    
    [self.navigationController pushViewController:yellowPageVc animated:YES];
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
        
        // 1.拷贝一个可变的联系人模型
        CNMutableContact *mutableCt = contact.mutableCopy;
        
        // 2.添加电话信息
        CNPhoneNumber *number = [CNPhoneNumber phoneNumberWithStringValue:_phoneNumber];
        CNLabeledValue *value = [CNLabeledValue labeledValueWithLabel:@"主要" value:number];
        
        // 2.2交给可变联系人模型
        mutableCt.phoneNumbers = [contact.phoneNumbers arrayByAddingObject:value];
        
        // 3.创建保存请求
        CNSaveRequest *request = [[CNSaveRequest alloc] init];
        // 3.2请求更新联系人
        [request updateContact:mutableCt];
        
        // 4.获取通讯录
        CNContactStore *store = [[CNContactStore alloc] init];
        // 4.2 执行保存请求
        [store executeSaveRequest:request error:nil];
        
        // 5.创建显示联系人的控制器
        CNContactViewController *vc = [CNContactViewController viewControllerForNewContact:mutableCt];
        vc.navigationItem.title = @"添加到已有";
        vc.delegate = self;
        
        // 5.2 包成导航控制器
        MDRNavigationController *nav = [[MDRNavigationController alloc] initWithRootViewController:vc];
        
        // 6.显示添加到已有联系人的界面
        [self presentViewController:nav animated:YES completion:nil];
        
    });
    
}






@end
