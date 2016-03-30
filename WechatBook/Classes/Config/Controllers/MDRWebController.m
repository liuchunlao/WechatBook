//
//  MDRWebController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/30.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRWebController.h"

@interface MDRWebController ()

@end

@implementation MDRWebController

- (void)loadView {

    self.view = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = (UIWebView *)self.view;
    
    NSURL *url = [NSURL URLWithString:@"http://dianhua.qq.com/v2/commonweal/main?uuid=553254713&auth=eiXchoouJlj%2Bwxgr6esXUJcJyv%2FOV664Uqa%2BfuLE0Gk%3D&devid=05B05C7CCAA0473180EE6A80BB1A57A9"];
    
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
