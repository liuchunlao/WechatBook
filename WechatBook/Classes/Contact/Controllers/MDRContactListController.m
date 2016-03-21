//
//  MDRContactListController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRContactListController.h"
#import <Contacts/CNContact+Predicates.h>
#import "MDRNavigationController.h"

@interface MDRContactListController () <CNContactViewControllerDelegate>

@property (nonatomic, weak) UIBarButtonItem *addContactItem;

@property (nonatomic, strong) NSArray *allPeoples;

@end

@implementation MDRContactListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.标题
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"免费", @"全部"]];
    
    segmentControl.width = 140;
    
    [segmentControl setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName : [UIColor whiteColor]
                                            } forState:UIControlStateSelected];
    
    [segmentControl setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName : MDRThemeColor
                                            } forState:UIControlStateNormal];
    
    segmentControl.selectedSegmentIndex = 1;
    
    self.navigationItem.titleView = segmentControl;
    
    [segmentControl addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    // 2.左侧按钮
    UIBarButtonItem *chooseItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(chooseItemClick:)];
    self.navigationItem.leftBarButtonItem = chooseItem;
    
    // 3.右侧按钮
    UIBarButtonItem *addContactItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_add_free_freinds"] style:UIBarButtonItemStylePlain target:self action:@selector(addContactItemClick)];
    self.navigationItem.rightBarButtonItem = addContactItem;
    
    self.addContactItem = addContactItem;
    
    MDRLog(@"%@", self.allPeoples);
}

#pragma mark - 点击选择调用
/**
 通过代码直接修改barbuttonItem的文字或图片是可能会同时显示两个
 */
- (void)chooseItemClick:(UIBarButtonItem *)sender {

    if ([sender.title isEqualToString:@"选择"]) {

        sender.title = @"取消";
        self.addContactItem.title = @"全选";
        self.addContactItem.image = nil;
        
        
    } else {
    
        sender.title = @"选择";
        self.addContactItem.title = nil;
        self.addContactItem.image = [UIImage imageNamed:@"icon_add_free_freinds"];

        
    }

    
    
    
}

#pragma mark - 刷新列表
- (void)segmentControlValueChanged:(UISegmentedControl *)segment {

    MDRLog(@"刷新联系人信息");
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}








#pragma mark - 点击添加联系人
- (void)addContactItemClick {
    
    MDRLog(@"添加联系人");
    // 1.创建控制器
    CNContactViewController *addContactVc = [CNContactViewController viewControllerForNewContact:[[CNContact alloc] init]];
    
    
    addContactVc.delegate = self;
    
    // 2.包成导航控制器
    MDRNavigationController *nav = [[MDRNavigationController alloc] initWithRootViewController:addContactVc];
    
    // 3.显示控制器
    [self presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark - CNContactViewControllerDelegate
- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(nullable CNContact *)contact {

    // 销毁控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 懒加载
- (NSArray *)allPeoples {
    if (!_allPeoples) {
        
        // 1.创建通讯录对象
//        CNContactStore *store = [[CNContactStore alloc] init];
//        
//        // 2.获取所有的联系人数据
//        NSPredicate *dicate = [CNContact predicateForContactsInGroupWithIdentifier:nil];
//        
//        _allPeoples = [store unifiedContactsMatchingPredicate:nil keysToFetch:@[] error:nil];
//        
//        MDRLog(@"%@", @(_allPeoples.count));
    }
    return _allPeoples;
}


@end
