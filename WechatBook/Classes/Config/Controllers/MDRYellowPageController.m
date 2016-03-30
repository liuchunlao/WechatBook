//
//  MDRYellowPageController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/27.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRYellowPageController.h"

@interface MDRYellowPageController ()

@end

@implementation MDRYellowPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"黄页";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 显示系统的背景
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
