//
//  MDRSettingHomeController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRSettingHomeController.h"
#import "MDRSetHomeHeaderView.h"

@interface MDRSettingHomeController ()

@end

@implementation MDRSettingHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置标题
    self.navigationItem.title = @"设置";
    
    // 2.加载首页的plist文件数据
    self.plistName = @"MDRSettingHome";
    
    // 3.设置顶部的视图
    self.tableView.tableHeaderView = [MDRSetHomeHeaderView homeHeaderView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 0;
    }
    return 20;
}



@end
