//
//  MDRPlayBookController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/30.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRPlayBookController.h"

@interface MDRPlayBookController ()

@end

@implementation MDRPlayBookController
- (void)loadView {
    
    self.view = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = (UIWebView *)self.view;
    
    // 婉转电话本的链接
    NSURL *url = [NSURL URLWithString:@"http://dianhua.qq.com/v2/weixin_notice?lang=zh_CN&t=weixin_notices&platform=ios&new=0&expand=0&version=2_2_4"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
