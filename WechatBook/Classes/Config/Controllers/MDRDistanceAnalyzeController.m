//
//  MDRDistanceAnalyzeController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/30.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRDistanceAnalyzeController.h"

@interface MDRDistanceAnalyzeController ()

@end

@implementation MDRDistanceAnalyzeController

- (void)loadView {
    
    self.view = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = (UIWebView *)self.view;
    
    // 婉转电话本的链接
    NSURL *url = [NSURL URLWithString:MDRDistanceAnalyze];
    
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
