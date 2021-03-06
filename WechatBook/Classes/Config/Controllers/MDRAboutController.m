//
//  MDRAboutController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/22.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRAboutController.h"
#import "MDRAboutHeaderView.h"

@implementation MDRAboutController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // 1.logo
    self.tableView.tableHeaderView = [MDRAboutHeaderView aboutHeaderView];
    
    // 2.版权说明 需要适配不同屏幕调整高度
    UIView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"MDRAboutFooterView" owner:nil options:nil] lastObject];
    
    footerView.height = [UIScreen mainScreen].bounds.size.height - self.tableView.tableHeaderView.height - 4 * 44 - 100;
    
    self.tableView.tableFooterView = footerView;
    
    // 3.此页面不能滚动
    if (MDRScreenH > 480) {
        self.tableView.scrollEnabled = NO;
    } else {
    
        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    }
    
    
}

// 防止第一行cell被覆盖一部分内容
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 20;
}

@end
